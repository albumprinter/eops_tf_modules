# Required
## e.g. lambda.amazonaws.com, events.amazonaws.com, etc
variable "assume_role_principal" {}

variable "tags" {}

variable "policy_statements" {}

# Optional
variable "description" {
  default = null
}

variable "force_detach_policies" {
  default = null
}

variable "max_session_duration" {
  default = null
}

variable "name" {
  default = null
}

variable "name_prefix" {
  default = null
}

variable "path" {
  default = null
}

variable "permissions_boundary" {
  default = null
}

variable "policy_description" {
  default = null
}

variable "policy_name" {
  default = null
}

variable "policy_name_prefix" {
  default = null
}

variable "policy_path" {
  default = null
}

# Custom
variable "assume_role_principal_type" {
  default = "Service"
}
