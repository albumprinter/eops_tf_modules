# Required
variable "name" {}

# Optional
variable "description" {
  default = null
}
variable "endpoint_configuration_types" {
  default = null
}
variable "binary_media_types" {
  default = null
}
variable "minimum_compression_size" {
  default = null
}
variable "body" {
  default = null
}
variable "policy" {
  default = null
}
variable "api_key_source" {
  default = null
}

# Custom
variable "provision" {
  default = true
}
