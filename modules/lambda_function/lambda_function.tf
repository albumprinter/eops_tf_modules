module "lambda_function" {
  source = "../../resources/lambda_function"

  # Required
  dead_letter_queue_target_arn = var.function_dead_letter_target_type == "SQS" ? module.dead_letter_queue.queue_arn : module.dead_letter_topic.topic_arn
  handler                      = var.function_handler
  name                         = var.function_name
  role                         = module.role.iam_role_arn
  runtime                      = var.function_runtime
  tags                         = local.tags

  # Conditonally Required
  filename          = var.function_filename
  s3_bucket         = var.function_s3_bucket
  s3_key            = var.function_s3_key
  s3_object_version = var.function_s3_object_version

  #Optional
  environment_variables          = var.function_environment_variables
  description                    = var.function_description
  kms_key_arn                    = var.function_kms_key_arn
  layers                         = var.function_layers
  memory_size                    = var.function_memory_size
  publish                        = var.function_publish
  reserved_concurrent_executions = var.function_reserved_concurrent_executions
  source_code_hash               = var.function_source_code_hash
  timeout                        = var.function_timeout
  vpc_config_subnet_ids          = var.function_vpc_config_subnet_ids
  vpc_config_security_group_ids  = var.function_vpc_config_security_group_ids
}

module "role" {
  source = "../../resources/iam_role"

  assume_role_principal = "lambda.amazonaws.com"
  # Required  
  policy_statements = concat(var.iam_role_policy_statements, [
    {
      "Effect" : "Allow",
      "Action" : [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource" : ["arn:aws:logs:*:*:*"]
    },
    {
      "Effect" : "Allow",
      "Action" : [
        "${var.function_dead_letter_target_type == "SQS" ? "sqs:SendMessage" : "sns:Publish"}"
      ],
      "Resource" : ["${var.function_dead_letter_target_type == "SQS" ? module.dead_letter_queue.queue_arn : module.dead_letter_topic.topic_arn}"]
    }
    ],
    length(var.function_vpc_config_subnet_ids) == 0 ? [] : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface"
        ],
        "Resource" : ["*"]
      }
  ])
  tags = local.tags

  # Optional
  description           = var.iam_role_description
  force_detach_policies = var.iam_role_force_detach_policies
  max_session_duration  = var.iam_role_max_session_duration
  name                  = var.iam_role_name != null ? var.iam_role_name : "${var.function_name}"
  name_prefix           = var.iam_role_name_prefix
  path                  = var.iam_role_path
  permissions_boundary  = var.iam_role_permissions_boundary
  policy_description    = var.iam_role_policy_description
  policy_name           = var.iam_role_policy_name != null ? var.iam_role_policy_name : "${var.function_name}"
  policy_name_prefix    = var.iam_role_policy_name_prefix
  policy_path           = var.iam_role_policy_path
}

module "log_group" {
  source = "../../resources/cloudwatch_log_group"

  # Required
  tags = local.tags

  # Optional
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_group_retention_in_days
  kms_key_id        = var.log_group_kms_key_id
}


module "dead_letter_queue" {
  source  = "../../resources/sqs_queue"
  provision = var.function_dead_letter_target_type == "SQS" ? true : false

  # Required
  tags = local.tags

  # Optional
  name                              = var.function_dead_letter_target_name != null ? var.function_dead_letter_target_name : "${var.function_name}_dead_letter_queue"
  content_based_deduplication       = var.sqs_queue_content_based_deduplication
  delay_seconds                     = var.sqs_queue_delay_seconds
  fifo_queue                        = var.sqs_queue_fifo_queue
  kms_data_key_reuse_period_seconds = var.sqs_queue_kms_data_key_reuse_period_seconds
  kms_master_key_id                 = var.sqs_queue_kms_master_key_id
  message_retention_seconds         = var.sqs_queue_message_retention_seconds
  max_message_size                  = var.sqs_queue_max_message_size
  policy                            = var.sqs_queue_policy
  receive_wait_time_seconds         = var.sqs_queue_receive_wait_time_seconds
  redrive_policy                    = var.sqs_queue_redrive_policy
  visibility_timeout_seconds        = var.sqs_queue_visibility_timeout_seconds
}

module "dead_letter_topic" {
  source  = "../../resources/sns_topic"
  provision = var.function_dead_letter_target_type == "SNS" ? true : false

  # Required
  tags = local.tags

  # Optional
  name                                     = var.function_dead_letter_target_name != null ? var.function_dead_letter_target_name : "${var.function_name}_dead_letter_topic"
  policy                                   = var.sns_topic_policy
  delivery_policy                          = var.sns_topic_delivery_policy
  application_success_feedback_role_arn    = var.sns_topic_application_success_feedback_role_arn
  application_success_feedback_sample_rate = var.sns_topic_application_success_feedback_sample_rate
  application_failure_feedback_role_arn    = var.sns_topic_application_failure_feedback_role_arn
  http_success_feedback_role_arn           = var.sns_topic_http_success_feedback_role_arn
  http_success_feedback_sample_rate        = var.sns_topic_http_success_feedback_sample_rate
  http_failure_feedback_role_arn           = var.sns_topic_http_failure_feedback_role_arn
  kms_master_key_id                        = var.sns_topic_kms_master_key_id
  lambda_success_feedback_role_arn         = var.sns_topic_lambda_success_feedback_role_arn
  lambda_success_feedback_sample_rate      = var.sns_topic_lambda_success_feedback_sample_rate
  lambda_failure_feedback_role_arn         = var.sns_topic_lambda_failure_feedback_role_arn
  sqs_success_feedback_role_arn            = var.sns_topic_sqs_success_feedback_role_arn
  sqs_success_feedback_sample_rate         = var.sns_topic_sqs_success_feedback_sample_rate
  sqs_failure_feedback_role_arn            = var.sns_topic_sqs_failure_feedback_role_arn
}
