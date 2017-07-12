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

variable "app_name" {
  default = ""
}
variable "app_elb_name" {
  default = ""
}
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
  default = ""
}

variable "chef_user_key" {
  default = "eops.pem"
}

variable "user_keypath" {
  default = ""
}

variable "private_keypath" {
  default = ""
}

variable "chef_serverurl" {
  default = ""
}

variable "SG_cidr_blocks" {
  type = "list"
  default =  [""]
  }
variable "SG_elb_cidr_blocks" {
  type = "list"
  default =  [""]
}

variable "lb_port_outside" {
  default = "80"
}

variable "lb_protocol_outside" {
  default = "HTTP"
}

variable "instance_port_inside" {
  default = "80"
}

variable "instance_protocol_inside" {
  default = "HTTP"
}

variable "chef_client_version" {
  default = "12.10.24"
}

variable "ec2_sg_ingress_fromport" {
  default = "0"
}

variable "ec2_sg_ingress_toport" {
  default = "0"
}

variable "ec2_sg_ingress_protocol" {
  default = "-1"
}

variable "elb_sg_ingress_fromport" {
  default = "0"
}

variable "elb_sg_ingress_toport" {
  default = "0"
}

variable "elb_sg_ingress_protocol" {
  default = "-1"
}

variable "elb_healthcheck_target"  {
  default = "TCP:22"
}

variable "chef_attributes_json"  {
  default = <<-EOF
  {
    "key": "value"
  }
  EOF
}