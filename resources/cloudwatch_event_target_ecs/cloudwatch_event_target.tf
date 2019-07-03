resource "aws_cloudwatch_event_target" "target" {
  count = var.provision == true ? 1 : 0

  # Required
  arn  = var.arn
  rule = var.rule

  # Optional
  target_id  = var.target_id
  input      = var.input
  input_path = var.input_path
  role_arn   = var.role_arn
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
}