# Required
variable "rest_api_id" {}
variable "resource_id" {}
variable "http_method" {}
variable "status_code" {}

# Optional
variable "selection_pattern" {
  default = null
}
variable "response_templates" {
  default = null
}
variable "response_parameters" {
  default = null
}
variable "content_handling" {
  default = null
}

# Custom
variable "provision" {
  default = true
}
