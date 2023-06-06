resource "aws_iam_role" "role" {
  name               = "${local.prefix}-role"
  assume_role_policy = file("../templates/ec2_instance_profile_policy.json")

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "bastion-attach" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "${local.prefix}-bastion-profile"
  role = aws_iam_role.role.name
}

resource "aws_instance" "bastion" {
  ami                   = "ami-007855ac798b5175e"
  instance_type         = "t2.micro"
  user_data             = file("../templates/user_data.sh")
  iam_instance_profile  = aws_iam_instance_profile.bastion_profile.name
  key_name              = var.bastion_key_name
  subnet_id             = aws_subnet.public_subnet[0].id
  vpc_security_group_ids     = [aws_security_group.bastion.id]

  tags = merge(
    local.common_tags,
    tomap({"Name": "${local.prefix}-bastion"})
  )
}

resource "aws_security_group" "bastion" {
  name        = "${local.prefix}-bastion"
  description = "Allow TLS inbound and outbound traffic for selected ports"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "SSH to Instance"
    from_port        = 22
    to_port          = 222
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = [aws_subnet.private_subnet[0].cidr_block, aws_subnet.private_subnet[1].cidr_block]
  }

  tags = merge(
    local.common_tags, tomap({"Name":"${local.prefix}-bastion-SG"})
  )
}
