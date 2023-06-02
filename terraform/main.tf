terraform{
    backend "s3" {
        bucket = "conduit-achebe"
        key = "terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        dynamodb_table = "conduit-app-tfstate-lock"
    }
}

provider "aws" {
    region = "us-east-1"
}

locals {
    prefix = "${var.}-${terraform.workspace}"
    common_tags = {
        Enivironment = "${terraform.workspace}"
        Project = "${var.project}"
        Owner = "${var.contact}"
        ManagedBy = "Terraform"
    }
}

resource "aws_instance" "my_vm" {
 ami           = var.ami //Ubuntu AMI
 instance_type = var.instance_type

 tags = merge(local.common_tags, tomap({"Name":var.name_tag}))
}