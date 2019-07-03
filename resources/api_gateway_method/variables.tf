# Required
variable "rest_api_id" {}
variable "resource_id" {}
variable "http_method" {}
variable "authorization" {}

# Optional
variable "authorizer_id" {
  default = null
}
variable "authorization_scopes" {
  default = null
}
variable "api_key_required" {
  default = null
}
variable "request_models" {
  default = null
}
variable "request_validator_id" {
  default = null
}
variable "request_parameters" {
  default = null
}

# Custom
variable "provision" {
  default = true
}