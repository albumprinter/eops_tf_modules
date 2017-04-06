variable "region" {
  default = "eu-west-1"
}
variable "account_type" {
  default = "sandbox"
}
variable "tags_business_unit" {
  default = "Albumprinter"
}
variable "tags_cost_center" {
  default = "CC443100"
}
variable "tags_team" {}
variable "tags_purpose" {
  default = ""
}
variable "description" {}
variable "app_name" {}

variable "environment" {}
variable "variables" {
  default = ""
}
variable "enabled" {
  default = 1
}
variable "private" {
  default = false
}

variable "response_template" {
  type = "map"
  default ={
    "application/json" = ""
  }
}

variable "instance_count" {
  default = 1
}
variable "iam_policy_document" {
  default =<<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}
variable "ami" {
  default = "ami-971238f1"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "availability_zone" {
  default = "eu-west-1a"
}

variable "chef_run_list" {
  type = "list"
}

variable "key_name" {
  default = "aws-eops-sandbox"
}

variable "chef_user_key" {
  default = "eops.pem"
}