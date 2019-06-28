# Required
variable "arn" {}
variable "rule" {}

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
variable "run_command_targets_key" {
  default = null
}
variable "run_command_targets_values" {
  default = null
}
variable "ecs_target_group" {
  default = null
}
variable "ecs_target_launch_type" {
  default = null
}
variable "ecs_target_subnets" {
  default = null
}
variable "ecs_target_security_groups" {
  default = null
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
variable "ecs_target_task_definition_arn" {
  default = null
}
variable "batch_target_job_definition" {
  default = null
}
variable "batch_target_job_name" {
  default = null
}
variable "batch_target_array_size" {
  default = null
}
variable "batch_target_job_attempts" {
  default = null
}
variable "kinesis_target_partition_key_path" {
  default = null
}
variable "sqs_target_message_group_id" {
  default = null
}
variable "input_transformer_input_paths" {
  default = null
}
variable "input_transformer_input_template" {
  default = null
}

# Custom
variable "enabled" {
  default = true
}