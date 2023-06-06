variable contact {
  type        = string
  default     = "achebepeter94@gmail.com"
}

variable project {
  type        = string
  default     = "Conduit-App"
}

variable "ami" {
   type        = string
   description = "Ubuntu AMI ID in N. Virginia Region"
   default     = "ami-065deacbcaac64cf2"
}

variable "instance_type" {
   type        = string
   description = "Instance type"
   default     = "t2.micro"
}

variable "name_tag" {
   type        = string
   description = "Name of the EC2 instance"
   default     = "My EC2 Instance"
}

variable prefix {
  type        = string
  default     = "conduit-app"
}

variable "db_user" {
    description = "Database user for RDS instance"
}

variable "db_password" {
    description = "Database password for RDS instance"
}

variable availability_zone {
    type = list
    default = ["us-east-1a", "us-east-1b"]
}
variable public_subnets_cidr {
  type = list
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable private_subnets_cidr {
  type = list
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "bastion_key_name" {
    default = "recipe-app-api-devops"
}

variable "django_secret_key" {
    description = "Django key of recipe app"
}
