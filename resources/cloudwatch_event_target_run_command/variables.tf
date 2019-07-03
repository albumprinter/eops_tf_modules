# Required
variable "arn" {}
variable "rule" {}
variable "run_command_targets_key" {}
variable "run_command_targets_values" {}

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
variable "provision" {
  default = true
}