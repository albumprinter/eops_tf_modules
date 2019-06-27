variable "region" {
  default = "eu-west-1"
}
variable "tags_business_unit" {
  default = "Albumprinter"
}
variable "tags_cost_center" {
  default = "CC443100"
}
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
variable "retention_days" {
  default = "30"
}
variable "log_group_name" {  
}
variable "pattern" {
  default = "[type=REPORT,...,MemUsed,MemUnit]"
}
variable "alarm_action_enabled" {
  default = "true"
}