variable "tags" {}
variable "name" {
  default = null
}
variable "name_prefix" {
  default = null
}
variable "description" {
  default = null
}
variable "revoke_rules_on_delete" {
  default = null
}
variable "vpc_id" {
  default = null
}
variable "ingress_rules" {
  type = "list"
  default = []
}
variable "egress_rules" {
  type = "list"
  default = []
}
