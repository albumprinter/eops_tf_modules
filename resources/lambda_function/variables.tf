# Required
variable "dead_letter_queue_target_arn" {}

variable "name" {}

variable "handler" {}

variable "runtime" {}

variable "tags" {}

# Conditionally Required
variable "filename" {
  default = null
}

variable "s3_bucket" {
  default = null
}

variable "s3_key" {
  default = null
}

variable "s3_object_version" {
  default = null
}

# Optional

variable "role" {
  default = null
}

variable "environment_variables" {
  type    = "map"
  default = {}
}

variable "description" {
  default = null
}

variable "kms_key_arn" {
  default = null
}

variable "layers" {
  default = null
}

variable "memory_size" {
  default = null
}

variable "publish" {
  default = null
}

variable "reserved_concurrent_executions" {
  default = null
}

variable "source_code_hash" {
  default = null
}

variable "timeout" {
  default = null
}

variable "vpc_config_subnet_ids" {
  default = []
}

variable "vpc_config_security_group_ids" {
  default = []
}
