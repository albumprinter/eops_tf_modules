# Required
variable "arn" {}
variable "rule" {}

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