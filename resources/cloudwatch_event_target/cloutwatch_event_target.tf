resource "aws_cloudwatch_event_target" "target" {
  count = var.enabled == true ? 1 : 0

  # Required
  arn  = var.arn
  rule = var.rule

  # Optional
  target_id  = var.target_id
  input      = var.input
  input_path = var.input_path
  role_arn   = var.role_arn
  run_command_targets {
    key    = var.run_command_targets_key
    values = var.run_command_targets_values
  }
  ecs_target {
    group       = var.ecs_target_group
    launch_type = var.ecs_target_launch_type
    network_configuration {
      subnets          = var.ecs_target_subnets
      security_groups  = var.ecs_target_security_groups
      assign_public_ip = var.ecs_target_assign_public_ip
    }
    platform_version    = var.ecs_target_platform_version
    task_count          = var.ecs_target_task_count
    task_definition_arn = var.ecs_target_task_definition_arn
  }
  batch_target {
    job_definition = var.batch_target_job_definition
    job_name       = var.batch_target_job_name
    array_size     = var.batch_target_array_size
    job_attempts   = var.batch_target_job_attempts
  }
  kinesis_target {
    partition_key_path = var.kinesis_target_partition_key_path
  }
  sqs_target {
    message_group_id = var.sqs_target_message_group_id
  }
  input_transformer {
    input_paths    = var.input_transformer_input_paths
    input_template = var.input_transformer_input_template
  }
}