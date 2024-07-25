variable "region" {
  default = "eu-west-1"
}

variable "account_type" {
}

variable "tags_business_unit" {
  default = "Albumprinter"
}
variable "tags_cost_center" {}
variable "tags_team" {}
variable "tags_domain" {}
variable "tags_purpose" {
  default = ""
}
variable "description" {}
variable "app_name" {}
variable "runtime" {
  default = "nodejs4.3"
}
variable "handler" {}
variable "environment" {}
variable "variables" {
  type = map(string)
  default = {
    env = ""
  }
}
variable "lambda_bucket_name" {
  default = ""
}
variable "memory_size" {
  default = "128"
}
variable "timeout" {
  default = "3"
}
variable "enabled" {
  default = 1
}
variable "private" {
  default = false
}
variable "vpc_enabled" {
  default = true
}
variable "response_template" {
  type = map(string)

  default = {
    "application/json" = ""
  }
}
variable "iam_policy_document" {
  default = ""
}
variable "lambda_sns_subscription_arn" {
  default = ""
}
variable "lambda_memory_alert_threshold" {
  default = "120"
}
variable "alarm_action_arn" {
  default = ""
}
variable "retention_days" {
  default = "30"
}
variable "reserved_concurrent_executions" {
  default = -1
}
variable "sns_subscription_filters" {
  default = ""
}
variable "enable_cloudwatch_alarms" {
  default = "1"
}