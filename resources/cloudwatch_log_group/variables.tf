# Required
variable "tags" {}

# Optional
variable "name" {
  default = null
}

variable "name_prefix" {
  default = null
}

variable "retention_in_days" {
  default = null
}

variable "kms_key_id" {
  default = null
}

