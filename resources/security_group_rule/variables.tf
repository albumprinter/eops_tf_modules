variable "type" {}
variable "from_port" {}
variable "protocol" {}
variable "security_group_id" {}
variable "to_port" {}


variable "cidr_blocks" {
  default = null
  type = "list"
}
variable "ipv6_cidr_blocks" {
  default = null
  type = "list"
}
variable "prefix_list_ids" {
  default = null
  type = "list"
}
variable "source_security_group_id" {
  default = null
}
variable "self" {
  default = null
}
variable "description" {
  default = null
}