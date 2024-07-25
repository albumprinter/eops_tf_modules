variable "ami_id" {}
variable "instance_type" {}
variable "environment" {}
variable "team_name" {}
variable "app_name" {}
variable "aws_key_name" {}
variable "domain" {}
variable "user_data" {}
variable "desired_nodes" {}
variable "vpc_id" {}

variable "asg_sg_ingress" {
  type = "list"
}

variable "elb_sg_ingress" {
  type = "list"
}

variable "subnet_ids" {
  type = "list"
}

variable "elb_subnets" {
  type = "list"
}

variable "elb_listeners" {
  type = "list"
}

variable "asg_tags" {
  type = "list"
}

variable "asg_sg_tags" {
  type = map(string)
}

variable "elb_sg_tags" {
  type ="map"
}

variable "security_groups" {
  type = "list"
  default = []
}

variable "elb_security_groups" {
  type = "list"
  default = []
}

variable "elb_tags" {
  type = map(string)
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

variable "target" {
  default = "HTTP:80/"
}

variable "interval" {
  default = 10
}

variable "cross_zone_load_balancing" {
  default = true
}

variable "idle_timeout" {
  default = 300
}

variable "connection_draining" {
  default = true
}

variable "connection_draining_timeout" {
  default = 300
}