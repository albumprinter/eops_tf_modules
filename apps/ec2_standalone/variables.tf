variable "region" {
  default = "eu-west-1"
}
variable "account_type" {
  default = "sandbox"
}

variable "user_data" {
  default = ""
}

## EC2 specification
variable "ami_id" {
  # 091716275804/Ubuntu 16.04
  default = "ami-ab5e0ed8"
}
variable "instance_type" {
  default = "t2.nano"
}
variable "number_servers" {
  default = 1
}
variable "associtate_public_ip"{
  default = false
}
variable "subnet_id" {}

## Tags
variable "tags_business_unit" {
  default = "Albumprinter"
}
variable "tags_purpose" {}
variable "tags_cost_center" {}
variable "tags_domain" {}
variable "tags_team" {}
variable "tags_name" {}
variable "tags_contact" {}

### Used in tags...and other places
variable "description" {}
variable "environment" {}
variable "application_name" {}

## Security group
variable "sg_name" {}
variable "sg_description" {}

## Keys
variable "key_name" {}
variable "public_key" {}