# Required
variable "tags" {
  default = null
}

# Conditionally Required
variable "event_pattern" {
  default = null
}
variable "schedule_expression" {
  default = null
}

# Optional
variable "description" {
  default = null
}
variable "name" {
  default = null
}
variable "name_prefix" {
  default = null
}
variable "role_arn" {
  default = null
}
variable "is_enabled" {
  default = null
}

# Custom
variable "provision" {
  default = true
}