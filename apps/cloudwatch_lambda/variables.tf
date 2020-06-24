variable "region" {
  default = "eu-west-1"
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
variable "environment" {}


variable "period" {
  default = "60"  #it's seconds damn it!
}
variable "alarm_threshold" {}
variable "alarm_action_arn" {}
variable "alarm_timeout" {}
variable "retention_days" {
  default = "30"
}
variable "log_group_name" {
}
variable "pattern" {
  default = "[type=REPORT,...,label=\"Used:\", MemUsed,MemUnit=\"MB\"]"
}
variable "alarm_action_enabled" {
  default = "true"
}
variable "enable_cloudwatch_alarms" {}
variable "enable_cloudwatch_error_alarm" {
  default = 1
}
locals {
  enable_error_alarm = "${var.enable_cloudwatch_alarms == 1 ? var.enable_cloudwatch_error_alarm : var.enable_cloudwatch_alarms}"
}