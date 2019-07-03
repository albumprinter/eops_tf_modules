# Required
variable "arn" {}
variable "rule" {}
variable "kinesis_target_partition_key_path" {}

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