module "lambda_function" {
  source = "../../modules/lambda_function"

  function_name    = "eops_tf_modules_example_lambda_function"
  function_handler = var.function_handler
  function_runtime = var.function_runtime

  function_s3_bucket = var.function_s3_bucket
  function_s3_key    = var.function_s3_key

  tag_cost_center = var.tag_cost_center
  tag_environment = var.tag_environment
  tag_domain      = var.tag_domain

  iam_role_policy_statements = var.iam_role_policy_statements
}

module "lambda_function_vpc" {
  source = "../../modules/lambda_function"

  function_name    = "eops_tf_modules_example_lambda_function_vpc"
  function_handler = var.function_handler
  function_runtime = var.function_runtime

  function_s3_bucket = var.function_s3_bucket
  function_s3_key    = var.function_s3_key

  tag_cost_center = var.tag_cost_center
  tag_environment = var.tag_environment
  tag_domain      = var.tag_domain

  iam_role_policy_statements = var.iam_role_policy_statements

  function_vpc_config_subnet_ids         = data.aws_subnet_ids.private.ids
  function_vpc_config_security_group_ids = [data.aws_security_group.default.id]
}

module "lambda_function_sns" {
  source = "../../modules/lambda_function"

  function_name    = "eops_tf_modules_example_lambda_function_sns"
  function_handler = var.function_handler
  function_runtime = var.function_runtime

  function_s3_bucket = var.function_s3_bucket
  function_s3_key    = var.function_s3_key

  tag_cost_center = var.tag_cost_center
  tag_environment = var.tag_environment
  tag_domain      = var.tag_domain

  function_dead_letter_target_type = "SNS"
}

module "lambda_function_sns_vpc" {
  source = "../../modules/lambda_function"

  function_name    = "eops_tf_modules_example_lambda_function_sns_vpc"
  function_handler = var.function_handler
  function_runtime = var.function_runtime

  function_s3_bucket = var.function_s3_bucket
  function_s3_key    = var.function_s3_key

  tag_cost_center = var.tag_cost_center
  tag_environment = var.tag_environment
  tag_domain      = var.tag_domain

  function_dead_letter_target_type = "SNS"

  function_vpc_config_subnet_ids         = data.aws_subnet_ids.private.ids
  function_vpc_config_security_group_ids = [data.aws_security_group.default.id]
}

module "lambda_function_scheduled" {
  source = "../../modules/lambda_function"

  function_name    = "eops_tf_modules_example_lambda_function_scheduled"
  function_handler = var.function_handler
  function_runtime = var.function_runtime

  function_s3_bucket = var.function_s3_bucket
  function_s3_key    = var.function_s3_key

  tag_cost_center = var.tag_cost_center
  tag_environment = var.tag_environment
  tag_domain      = var.tag_domain

  event_rule_schedule_expression = "cron(0 2 * * ? *)"
}

module "lambda_function_scheduled_vpc" {
  source = "../../modules/lambda_function"

  function_name    = "eops_tf_modules_example_lambda_function_scheduled_vpc"
  function_handler = var.function_handler
  function_runtime = var.function_runtime

  function_s3_bucket = var.function_s3_bucket
  function_s3_key    = var.function_s3_key

  tag_cost_center = var.tag_cost_center
  tag_environment = var.tag_environment
  tag_domain      = var.tag_domain

  event_rule_schedule_expression = "cron(0 2 * * ? *)"

  function_vpc_config_subnet_ids         = data.aws_subnet_ids.private.ids
  function_vpc_config_security_group_ids = [data.aws_security_group.default.id]
}

module "lambda_function_event_pattern" {
  source = "../../modules/lambda_function"

  function_name    = "eops_tf_modules_example_lambda_function_event_pattern"
  function_handler = var.function_handler
  function_runtime = var.function_runtime

  function_s3_bucket = var.function_s3_bucket
  function_s3_key    = var.function_s3_key

  tag_cost_center = var.tag_cost_center
  tag_environment = var.tag_environment
  tag_domain      = var.tag_domain

  event_rule_event_pattern = <<PATTERN
{
  "detail-type": [
    "AWS Console Sign In via CloudTrail"
  ]
}
PATTERN
}

module "lambda_function_event_pattern_vpc" {
  source = "../../modules/lambda_function"

  function_name    = "eops_tf_modules_example_lambda_function_event_pattern_vpc"
  function_handler = var.function_handler
  function_runtime = var.function_runtime

  function_s3_bucket = var.function_s3_bucket
  function_s3_key    = var.function_s3_key

  tag_cost_center = var.tag_cost_center
  tag_environment = var.tag_environment
  tag_domain      = var.tag_domain

  event_rule_event_pattern = <<PATTERN
{
  "detail-type": [
    "AWS Console Sign In via CloudTrail"
  ]
}
PATTERN

  function_vpc_config_subnet_ids         = data.aws_subnet_ids.private.ids
  function_vpc_config_security_group_ids = [data.aws_security_group.default.id]
}

module "lambda_function_api_gateway" {
  source = "../../modules/lambda_function"

  function_name    = "eops_tf_modules_example_lambda_function_api_gateway"
  function_handler = var.function_handler
  function_runtime = var.function_runtime

  function_s3_bucket = var.function_s3_bucket
  function_s3_key    = var.function_s3_key

  tag_cost_center = var.tag_cost_center
  tag_environment = var.tag_environment
  tag_domain      = var.tag_domain

  api_gateway_rest_api_name = "lambda_function_api_gateway"
}