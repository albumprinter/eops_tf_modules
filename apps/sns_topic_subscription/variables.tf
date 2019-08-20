variable "region" {
  default = "eu-west-1"
}
variable "account_type" {}
variable "tags_business_unit" {
  default = "Albumprinter"
}
variable "tags_cost_center" {}
variable "tags_team" {
  default = ""
}
variable "tags_purpose" {
  default = ""
}
variable "description" {
  default = ""
}
variable "app_name" {
  default = ""
}

variable "environment" {
  default = ""
}
variable "variables" {
  default = ""
}

variable "availability_zone" {
  default = "eu-west-1a"
}

variable topic_arn {
  default = ""
}

variable protocol {
  default = ""
}

variable endpoint {
  default = ""
}
