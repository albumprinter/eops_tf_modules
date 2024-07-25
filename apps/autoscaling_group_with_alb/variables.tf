variable "ami_id" {}
variable "instance_type" {}
variable "environment" {}
variable "team_name" {}
variable "app_name" {}
variable "aws_key_name" {}
variable "domain" {}
variable "user_data" {}
variable "desired_nodes" {}
variable "min_size" { default = 0 }
variable "max_size" { default = 0 }
variable "vpc_id" {}
variable "tg_port" {}
variable "tg_protocol" {}

variable "asg_sg_ingress" {
  type = "list"
}

variable "alb_sg_ingress" {
  type = "list"
}

variable "subnet_ids" {
  type = "list"
}

variable "alb_subnets" {
  type = "list"
}

variable "asg_tags" {
  type = "list"
}

variable "asg_sg_tags" {
  type = "map"
}

variable "alb_sg_tags" {
  type ="map"
}

variable "security_groups" {
  type = "list"
  default = []
}

variable "alb_security_groups" {
  type = "list"
  default = []
}

variable "alb_tags" {
  type = "map"
}

variable "associate_public_ip" {
  default = false
}

variable "alb_deletion_protection" {
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

variable "is_internal" {
  default = false
}

variable "healthy_threshold" {
  default = 2
}

variable "unhealthy_threshold" {
  default = 2
}

variable "timeout" {
  default = 3
}

variable "health_check_path" {
  default = "/"
}

variable "interval" {
  default = 10
}

variable "deregistration_delay" {
  default = 300
}

