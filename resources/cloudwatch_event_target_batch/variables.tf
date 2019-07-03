# Required
variable "arn" {}
variable "rule" {}
variable "batch_target_job_definition" {}
variable "batch_target_job_name" {}

# Optional
variable "target_id" {
  default = null
}
variable "input" {
  default = null
}
variable "input_path" {
  default = null
}
variable "role_arn" {
  default = null
}
variable "batch_target_array_size" {
  default = null
}
variable "batch_target_job_attempts" {
  default = null
}

# Custom
variable "provision" {
  default = true
}