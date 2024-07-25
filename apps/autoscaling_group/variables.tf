variable "ami_id" {}
variable "instance_type" {}
variable "environment" {}
variable "app_name" {}
variable "aws_key_name" {}
variable "domain" {}
variable "user_data" {}
variable "desired_nodes" {}
variable "min_size" { default = 0 }
variable "max_size" { default = 0 }

variable "team_name" {}
variable "vpc_id" {}

variable "asg_sg_ingress" {
  type = "list"
}

variable "asg_sg_tags" {
  type = map(string)
}

variable "subnet_ids" {
  type = "list"
}

variable "asg_tags" {
  type = "list"
}

variable "security_groups" {
  type = "list"
  default = []
}

variable "associate_public_ip" {
  default = false
}

variable "role_policy" {
  default = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1468377974000",
            "Effect": "Allow",
            "Action": [
                "autoscaling:DescribeAutoScalingInstances",
                "ec2:DescribeInstances"
            ],
            "Resource": ["*"]
        }
    ]
}
    EOF
}

variable "role_policy_description" {
  default = "This policy is used for Autoclustering features."
}