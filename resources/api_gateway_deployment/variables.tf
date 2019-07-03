# Required
variable "rest_api_id" {}

# Optional
variable "stage_name" {
  default = null
}
variable "description" {
  default = null
}
variable "stage_description" {
  default = null
}
variable "variables" {
  default = null
}

# Custom
variable "provision" {
  default = true
}