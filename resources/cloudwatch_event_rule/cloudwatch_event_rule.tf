resource "aws_cloudwatch_event_rule" "rule" {
  count = var.provision == true ? 1 : 0

  # Required
  tags = var.tags

  #Conditionally Required
  event_pattern       = var.event_pattern
  schedule_expression = var.schedule_expression


  # Optional
  description = var.description
  name        = var.name
  name_prefix = var.name_prefix
  role_arn    = var.role_arn
  is_enabled  = var.is_enabled
}
