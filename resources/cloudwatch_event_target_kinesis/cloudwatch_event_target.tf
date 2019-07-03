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
  kinesis_target {
    partition_key_path = var.kinesis_target_partition_key_path
  }
}