resource "aws_lambda_permission" "permission" {
  count = var.provision == true ? 1 : 0

  # Required
  action = var.action
  function_name = var.function_name
  principal = var.principal

  # Optional
  event_source_token = var.event_source_token
  qualifier = var.qualifier
  source_account  = var.source_account
  source_arn = var.source_arn
  statement_id = var.statement_id
  statement_id_prefix = var.statement_id_prefix
}