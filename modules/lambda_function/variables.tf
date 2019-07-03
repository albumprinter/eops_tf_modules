## ---------------- Shared ----------------
# Required
variable "tag_environment" {}

variable "tag_cost_center" {}

variable "tag_domain" {}

# Optional
variable "tag_others" {
  default = {}
}

## ---------------- Function ----------------
# Required
variable "function_name" {}

variable "function_handler" {}

variable "function_runtime" {}

# Conditionally Required
variable "function_filename" {
  default = null
}

variable "function_s3_bucket" {
  default = null
}

variable "function_s3_key" {
  default = null
}

variable "function_s3_object_version" {
  default = null
}

# Optional
variable "function_environment_variables" {
  type    = "map"
  default = {}
}

variable "function_description" {
  default = null
}

variable "function_kms_key_arn" {
  default = null
}

variable "function_layers" {
  default = null
}

variable "function_memory_size" {
  default = null
}

variable "function_publish" {
  default = null
}

variable "function_reserved_concurrent_executions" {
  default = null
}

variable "function_source_code_hash" {
  default = null
}

variable "function_timeout" {
  default = null
}

variable "function_vpc_config_subnet_ids" {
  default = []
}

variable "function_vpc_config_security_group_ids" {
  default = []
}

# Custom
variable "function_dead_letter_target_type" {
  default = "SQS"
}
variable "function_dead_letter_target_name" {
  default = null
}

## ---------------- Lambda Permission ----------------
# Optional
variable "lambda_permission_action" {
  default = "lambda:InvokeFunction"
} 
variable "lambda_permission_event_source_token" {
  default = null
} 
variable "lambda_permission_qualifier" {
  default = null
} 
variable "lambda_permission_source_account" {
  default = null
} 
variable "lambda_permission_source_arn" {
  default = null
} 
variable "lambda_permission_statement_id" {
  default = null
} 
variable "lambda_permission_statement_id_prefix" {
  default = null
} 

## ---------------- Event Rule ----------------
# Conditionally Required
variable "event_rule_event_pattern" {
  default = null
}
variable "event_rule_schedule_expression" {
  default = null
}
# Optional
variable "event_rule_description" {
  default = null
}
variable "event_rule_name" {
  default = null
}
variable "event_rule_name_prefix" {
  default = null
}
variable "event_rule_role_arn" {
  default = null
}
variable "event_rule_is_enabled" {
  default = null
}

## ---------------- Event Target ----------------
# Optional
variable "event_target_target_id" {
  default = null
}
variable "event_target_input" {
  default = null
}
variable "event_target_input_path" {
  default = null
}
variable "event_target_role_arn" {
  default = null
}
variable "event_target_input_transformer_input_paths" {
  default = null
}
variable "event_target_input_transformer_input_template" {
  default = null
}

## ---------------- Log Group ----------------
# Optional
variable "log_group_retention_in_days" {
  default = 30
}

variable "log_group_kms_key_id" {
  default = null
}

## ---------------- IAM Role ----------------
# Required
variable "iam_role_policy_statements" {
  default = []
}
# Optional
variable "iam_role_description" {
  default = null
}

variable "iam_role_force_detach_policies" {
  default = null
}

variable "iam_role_max_session_duration" {
  default = null
}

variable "iam_role_name" {
  default = null
}

variable "iam_role_name_prefix" {
  default = null
}

variable "iam_role_path" {
  default = null
}

variable "iam_role_permissions_boundary" {
  default = null
}

variable "iam_role_policy_description" {
  default = null
}

variable "iam_role_policy_name" {
  default = null
}

variable "iam_role_policy_name_prefix" {
  default = null
}

variable "iam_role_policy_path" {
  default = null
}

## ---------------- SNS Topic ----------------
# Optional
variable "sns_topic_policy" {
  default = null
}
variable "sns_topic_delivery_policy" {
  default = null
}
variable "sns_topic_application_success_feedback_role_arn" {
  default = null
}
variable "sns_topic_application_success_feedback_sample_rate" {
  default = null
}
variable "sns_topic_application_failure_feedback_role_arn" {
  default = null
}
variable "sns_topic_http_success_feedback_role_arn" {
  default = null
}
variable "sns_topic_http_success_feedback_sample_rate" {
  default = null
}
variable "sns_topic_http_failure_feedback_role_arn" {
  default = null
}
variable "sns_topic_kms_master_key_id" {
  default = null
}
variable "sns_topic_lambda_success_feedback_role_arn" {
  default = null
}
variable "sns_topic_lambda_success_feedback_sample_rate" {
  default = null
}
variable "sns_topic_lambda_failure_feedback_role_arn" {
  default = null
}
variable "sns_topic_sqs_success_feedback_role_arn" {
  default = null
}
variable "sns_topic_sqs_success_feedback_sample_rate" {
  default = null
}
variable "sns_topic_sqs_failure_feedback_role_arn" {
  default = null
}

## ---------------- SQS Queue ----------------
# Optional
variable "sqs_queue_content_based_deduplication" {
  default = null
}
variable "sqs_queue_delay_seconds" {
  default = null
}
variable "sqs_queue_fifo_queue" {
  default = null
}
variable "sqs_queue_kms_data_key_reuse_period_seconds" {
  default = null
}
variable "sqs_queue_kms_master_key_id" {
  default = null
}
variable "sqs_queue_message_retention_seconds" {
  default = null
}
variable "sqs_queue_max_message_size" {
  default = null
}
variable "sqs_queue_policy" {
  default = null
}
variable "sqs_queue_receive_wait_time_seconds" {
  default = null
}
variable "sqs_queue_redrive_policy" {
  default = null
}
variable "sqs_queue_visibility_timeout_seconds" {
  default = null
}

