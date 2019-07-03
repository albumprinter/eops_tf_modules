# Required
variable "action" {}
variable "function_name" {}
variable "principal" {}

# Optional
variable "event_source_token" {
  default = null
}
variable "qualifier" {
  default = null
}
variable "source_account" {
  default = null
}
variable "source_arn" {
  default = null
}
variable "statement_id" {
  default = null
}
variable "statement_id_prefix" {
  default = null
}

# Custom
variable "provision" {
  default = true
}
