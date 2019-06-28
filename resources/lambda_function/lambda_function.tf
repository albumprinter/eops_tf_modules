resource "aws_lambda_function" "function" {
  # Required
  function_name = var.name
  handler       = var.handler
  role          = var.role
  runtime       = var.runtime

  # Conditionally Required
  filename          = var.filename
  s3_bucket         = var.s3_bucket
  s3_key            = var.s3_key
  s3_object_version = var.s3_object_version

  #Optional
  environment {
    variables = length(var.environment_variables) > 0 ? var.environment_variables : { dead_letter_arn = var.dead_letter_queue_target_arn }
  }
  dead_letter_config {
    target_arn = var.dead_letter_queue_target_arn
  }
  description                    = var.description
  kms_key_arn                    = var.kms_key_arn
  layers                         = var.layers
  memory_size                    = var.memory_size
  publish                        = var.publish
  reserved_concurrent_executions = var.reserved_concurrent_executions
  source_code_hash               = var.source_code_hash
  tags                           = var.tags
  timeout                        = var.timeout
  vpc_config {
    subnet_ids         = var.vpc_config_subnet_ids
    security_group_ids = var.vpc_config_security_group_ids
  }
}
