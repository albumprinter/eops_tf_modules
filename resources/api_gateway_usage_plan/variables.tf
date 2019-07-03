# Required
variable "name" {}

# Optional
variable "description" {
  default = null
}
variable "api_stages_api_id" {
  default = null
}
variable "api_stages_stage" {
  default = null
}
variable "quota_settings_limit" {
  default = null
}
variable "quota_settings_offset" {
  default = null
}
variable "quota_settings_period" {
  default = null
}
variable "throttle_settings_burst_limit" {
  default = null
}
variable "throttle_settings_rate_limit" {
  default = null
}
variable "product_code" {
  default = null
}

# Custom
variable "provision" {
  default = true
}
