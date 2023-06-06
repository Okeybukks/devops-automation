# resource "aws_autoscaling_group" "asg" {
#   name             = "${var.prefix}-asg"
#   min_size         = 2
#   max_size         = 5
#   desired_capacity = 4
#   launch_template = {
#     id      = aws_launch_template.launch_template.id
#     version = "$Latest"
#   }
#   vpc_zone_identifier = aws_subnet.my_subnets[*].id
# }

 resource "aws_eks_node_group" "worker-node-group" {
  cluster_name  = aws_eks_cluster.devopsthehardway-eks.name
  node_group_name = "workernodes"
  node_role_arn  = aws_iam_role.workernodes.arn
  subnet_ids   = aws_subnet.subnets.*.id
  instance_types = ["t2.medium"]
 
  scaling_config {
   desired_size = 2
   max_size   = 3
   min_size   = 2
  }
 
  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
  ]
 }

