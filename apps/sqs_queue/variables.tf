variable "queue_name" {
}
variable "add_stale_message_cloudwatch" {
  default = 1
} 
variable "add_error_messages_cloudwatch" {
  default = 1
}
variable "extra_policy_statements" {
  default = ""
}
variable "sns_alert_arn" {
  default = ""
}
variable "description" {
  default = ""
}
variable "receive_wait_time_seconds" {
  default = "20"
}
variable "message_retention_seconds" {
  default = "1209600"
}
variable "visibility_timeout_seconds" {
  default = 120
}
variable "redrive_policy_retry_count" {
  default = 3
}
variable "tags_business_unit" {
  default = "Albumprinter"
}
variable "tags_cost_center" {}
variable "tags_team" {}
variable "tags_domain" {}
variable "tags_purpose" {}
variable "environment" {}