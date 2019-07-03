# Required
variable "arn" {}
variable "rule" {}
variable "input_transformer_input_template" {}

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
variable "input_transformer_input_paths" {
  default = null
}

# Custom
variable "enabled" {
  default = true
}