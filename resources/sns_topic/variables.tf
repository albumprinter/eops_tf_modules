# Required
variable "tags" {
  default = null
}

# Optional
variable "name" {
  default = null
}
variable "name_prefix" {
  default = null
}
variable "display_name" {
  default = null
}
variable "policy" {
  default = null
}
variable "delivery_policy" {
  default = null
}
variable "application_success_feedback_role_arn" {
  default = null
}
variable "application_success_feedback_sample_rate" {
  default = null
}
variable "application_failure_feedback_role_arn" {
  default = null
}
variable "http_success_feedback_role_arn" {
  default = null
}
variable "http_success_feedback_sample_rate" {
  default = null
}
variable "http_failure_feedback_role_arn" {
  default = null
}
variable "kms_master_key_id" {
  default = null
}
variable "lambda_success_feedback_role_arn" {
  default = null
}
variable "lambda_success_feedback_sample_rate" {
  default = null
}
variable "lambda_failure_feedback_role_arn" {
  default = null
}
variable "sqs_success_feedback_role_arn" {
  default = null
}
variable "sqs_success_feedback_sample_rate" {
  default = null
}
variable "sqs_failure_feedback_role_arn" {
  default = null
}

# Custom
variable "provision" {
  default = true
}