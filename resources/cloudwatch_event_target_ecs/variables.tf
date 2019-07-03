# Required
variable "arn" {}
variable "rule" {}
variable "ecs_target_task_definition_arn" {}

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
variable "ecs_target_group" {
  default = null
}
variable "ecs_target_launch_type" {
  default = null
}
variable "ecs_target_subnets" {
  default = []
}
variable "ecs_target_security_groups" {
  default = []
}
variable "ecs_target_assign_public_ip" {
  default = null
}
variable "ecs_target_platform_version" {
  default = null
}
variable "ecs_target_task_count" {
  default = null
}

# Custom
variable "enabled" {
  default = true
}