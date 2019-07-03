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
  batch_target {
    job_definition = var.batch_target_job_definition
    job_name       = var.batch_target_job_name
    array_size     = var.batch_target_array_size
    job_attempts   = var.batch_target_job_attempts
  }
}