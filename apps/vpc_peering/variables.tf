variable "region" {
  default = "eu-west-1"
}
variable "account_type" {
  default = "sandbox"
}
variable "tf-remote-state-bucket-name" {
  default = "terraform-ap"
}
variable "tags_business_unit" {
  default = "Albumprinter"
}
variable "tags_cost_center" {
  default = "CC443100"
}
variable "tags_team" {}
variable "tags_domain" {}
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
variable "allow_remote_vpc_dns_resolution" {
  default = true
}
variable "peer_target_account_id" {
  description = "account that will accept the peer request"
  default = "047710374887"
}
variable "peer_source_account_id" {
  description = "account that will make the peer request"
  default = ""
}