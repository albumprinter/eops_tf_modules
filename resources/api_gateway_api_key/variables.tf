# Required
variable "name" {}

# Optional
variable "description" {
  default = null 
}
variable "enabled" {
  default = null 
}
variable "value" {
  default = null 
}

# Custom
variable "provision" {
  default = true
}
