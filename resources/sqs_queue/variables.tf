# Required
variable "tags" {}

# Optional
variable "content_based_deduplication" {
  default = null
}
variable "delay_seconds" {
  default = null
}
variable "fifo_queue" {
  default = null
}
variable "kms_data_key_reuse_period_seconds" {
  default = null
}
variable "kms_master_key_id" {
  default = null
}
variable "message_retention_seconds" {
  default = null
}
variable "max_message_size" {
  default = null
}
variable "name" {
  default = null
}
variable "name_prefix" {
  default = null
}
variable "policy" {
  default = null
}
variable "receive_wait_time_seconds" {
  default = null
}
variable "redrive_policy" {
  default = null
}
variable "visibility_timeout_seconds" {
  default = null
}

# Custom
variable "provision" {
  default = true
}