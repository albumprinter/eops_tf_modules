variable "region" {
  default = "eu-west-1"
}

variable "load_balancer_name" {}

variable "instance_port" {
  default = "80"
}

variable "instance_protocol" {
  default = "http"
}

variable "lb_port" {}
variable "lb_protocol" {}

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
  default = "TCP:80"
}

variable "interval" {
  default = 30
}

variable "tags_business_unit" {
  default = "Albumprinter"
}

variable "tags_cost_center" {
  default = "CC443100"
}

variable "tags_team" {
  default = "EOPS"
}

variable "tags_domain" {}

variable "tags_purpose" {}

variable "environment" {}

variable "description" {}

variable "sg-protocol" {
  default = "tcp"
}

variable "application_name" {}

variable "ami_id" {}

variable "instance_type" {
  default = "t2.small"
}

variable "servers" {}

variable "key_name" {}

variable "user_data" {
  default = ""
}

variable "ssh_sg" {}
