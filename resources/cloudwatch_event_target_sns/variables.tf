# Required
variable "arn" {}
variable "rule" {}
variable "sqs_target_message_group_id" {}

# Optional
variable "target_id" {
  default = null
}
variable "input" {
  default = null
}
variable "input_path" {
  default = null
}
variable "role_arn" {
  default = null
}

# Custom
variable "enabled" {
  default = true
}