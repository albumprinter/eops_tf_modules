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
}