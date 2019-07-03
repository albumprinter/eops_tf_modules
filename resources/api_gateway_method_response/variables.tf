# Required
variable "rest_api_id" {}
variable "resource_id" {}
variable "http_method" {}
variable "status_code" {}

# Optional
variable "response_models" {
  default = null
}
variable "response_parameters" {
  default = null
}

# Custom
variable "provision" {
  default = true
}
