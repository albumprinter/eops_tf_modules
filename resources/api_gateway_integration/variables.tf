# Required
variable "rest_api_id" {}
variable "resource_id" {}
variable "http_method" {}
variable "type" {}

# Optional
variable "integration_http_method" {
  default = null
}
variable "connection_type" {
  default = null
}
variable "connection_id" {
  default = null
}
variable "uri" {
  default = null
}
variable "credentials" {
  default = null
}
variable "request_templates" {
  default = null
}
variable "request_parameters" {
  default = null
}
variable "passthrough_behavior" {
  default = null
}
variable "cache_key_parameters" {
  default = null
}
variable "cache_namespace" {
  default = null
}
variable "content_handling" {
  default = null
}
variable "timeout_milliseconds" {
  default = null
}

# Custom
variable "provision" {
  default = true
}