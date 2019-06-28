# Lambda Function

This module provisions the following resources:

* Lambda Function
* IAM Role for the function
* CloudWatch Log Group for the function with a default retention period of 30 days
* Dead letter mechanism that can be either a SQS Queue (default) or a SNS Topic

As an optional resource, it's also possible to provision a *CloudWatch Event Rule*.

## Example with minimal configuration

```
module "lambda_function" {
  source = "../../modules/lambda_function"

  function_name    = "example"
  function_handler = var.function_handler
  function_runtime = var.function_runtime

  function_s3_bucket = var.function_s3_bucket
  function_s3_key    = var.function_s3_key

  tag_cost_center = var.tag_cost_center
  tag_environment = var.tag_environment
  tag_domain      = var.tag_domain
}
```

Other examples can be found in the [examples file](examples/lambda_function/main.tf) for this module.

## Required parameters

The following parameters are considered required by either the resources used in this modules or by the module itself.

However, some of them are dependent on how the module is configured. In these cases, a note is added to the description below.

### Shared by all resources

* **tag_environment**: required tag defined by company standards
* **tag_cost_center**: required tag defined by company standards
* **tag_domain**: required tag defined by company standards

### Lambda Function

* [function_name](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#function_name)
* [function_handler](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#handler)
* [function_runtime](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#runtime)
* [function_filename](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#filename)
  * Note: If defined, The `function_s3_`-prefixed options cannot be used.
* [function_s3_bucket](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#s3_bucket)
  * Note: Conflicts with `function_filename`
* [function_s3_key](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#s3_key)
  * Note: Conflicts with `function_filename`
* [function_s3_object_version](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#s3_object_version)
  * Note: Conflicts with `function_filename`

### IAM Role

* **iam_role_policy_statements**: IAM policy statements granting permissions to the function.
  * Note: The basic permissions to write log messages, send dead letter information, and manage VPC interfaces (if applicable) will be granted automatically and don't need to be listed here.

### CloudWatch Event Rule (if applicable)

* [event_rule_event_pattern](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html#event_pattern)
  * Note: Required, if `event_rule_schedule_expression` isn't specified
* [event_rule_schedule_expression](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html#schedule_expression)
  * Note: Required, if `event_rule_event_pattern` isn't specified

## Other parameters available

In order to make this module as flexbile as possible, the following parameters are also exposed and can be combine in any way *accepted by AWS*.

They follow the same name as in the offical Terraform documentation with the addition of a prefix (e.g. *function_*) to identify to which resource does the parameter belong to.

### Shared by all resources

* **tag_others**: map containing any extra tags that should be added to the resources except for the required tags.
  * Note: The tag `name` shouldn't be used in this map, otherwise all resources will be tagged with the same value.

### Lambda Function

* **function_has_event_rule**: a boolean (`true`/`false`) parameter indicating whether the function should be triggered by an event rule.
* **function_dead_letter_target_type**: a string parameter that indicates which type of dead letter mechanism should be used. Valid values are `SNS` or `SQS`, being `SQS` the default one.
* **function_dead_letter_target_name**: optional name for the dead letter mechanism (either a topic or a queue). If not passed, the default name will be either `"${var.function_name}_dead_letter_queue"` or `"${var.function_name}_dead_letter_topic"`
* [function_environment_variables](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#variables)
* [function_description](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#description)
* [function_kms_key_arn](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#kms_key_arn)
* [function_layers](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#layers)
* [function_memory_size](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#memory_size)
* [function_publish](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#publish)
* [function_reserved_concurrent_executions](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#reserved_concurrent_executions)
* [function_source_code_hash](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#source_code_hash)
* [function_timeout](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#timeout)
* [function_vpc_config_subnet_ids](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#subnet_ids)
* [function_vpc_config_security_group_ids](https://www.terraform.io/docs/providers/aws/r/lambda_function.html#security_group_ids)

### IAM Role

* [iam_role_description](https://www.terraform.io/docs/providers/aws/r/iam_role.html#description)
* [iam_role_force_detach_policies](https://www.terraform.io/docs/providers/aws/r/iam_role.html#force_detach_policies)
* [iam_role_max_session_duration](https://www.terraform.io/docs/providers/aws/r/iam_role.html#max_session_duration)
* [iam_role_name](https://www.terraform.io/docs/providers/aws/r/iam_role.html#name)
* [iam_role_name_prefix](https://www.terraform.io/docs/providers/aws/r/iam_role.html#name_prefix)
* [iam_role_path](https://www.terraform.io/docs/providers/aws/r/iam_role.html#path)
* [iam_role_permissions_boundary](https://www.terraform.io/docs/providers/aws/r/iam_role.html#permissions_boundary)
* [iam_role_policy_description](https://www.terraform.io/docs/providers/aws/r/iam_policy.html#description)
* [iam_role_policy_name](https://www.terraform.io/docs/providers/aws/r/iam_policy.html#name)
* [iam_role_policy_name_prefix](https://www.terraform.io/docs/providers/aws/r/iam_policy.html#name_prefix)
* [iam_role_policy_path](https://www.terraform.io/docs/providers/aws/r/iam_policy.html#path)

### CloudWatch Log Group

* [log_group_retention_in_days](https://www.terraform.io/docs/providers/aws/r/cloudwatch_log_group.html#retention_in_days)
* [log_group_kms_key_id](https://www.terraform.io/docs/providers/aws/r/cloudwatch_log_group.html#kms_key_id)

### Dead Letter SQS Queue

* [sqs_queue_content_based_deduplication](https://www.terraform.io/docs/providers/aws/r/sqs_queue.html#content_based_deduplication)
* [sqs_queue_delay_seconds](https://www.terraform.io/docs/providers/aws/r/sqs_queue.html#delay_seconds)
* [sqs_queue_fifo_queue](https://www.terraform.io/docs/providers/aws/r/sqs_queue.html#fifo_queue)
* [sqs_queue_kms_data_key_reuse_period_seconds](https://www.terraform.io/docs/providers/aws/r/sqs_queue.html#kms_data_key_reuse_period_seconds)
* [sqs_queue_kms_master_key_id](https://www.terraform.io/docs/providers/aws/r/sqs_queue.html#kms_master_key_id)
* [sqs_queue_message_retention_seconds](https://www.terraform.io/docs/providers/aws/r/sqs_queue.html#message_retention_seconds)
* [sqs_queue_max_message_size](https://www.terraform.io/docs/providers/aws/r/sqs_queue.html#max_message_size)
* [sqs_queue_policy](https://www.terraform.io/docs/providers/aws/r/sqs_queue.html#policy)
* [sqs_queue_receive_wait_time_seconds](https://www.terraform.io/docs/providers/aws/r/sqs_queue.html#receive_wait_time_seconds)
* [sqs_queue_redrive_policy](https://www.terraform.io/docs/providers/aws/r/sqs_queue.html#redrive_policy)
* [sqs_queue_visibility_timeout_seconds](https://www.terraform.io/docs/providers/aws/r/sqs_queue.html#visibility_timeout_seconds)

### Dead Letter SNS Topic

* [sns_topic_policy](https://www.terraform.io/docs/providers/aws/r/sns_topic.html#policy)
* [sns_topic_delivery_policy](https://www.terraform.io/docs/providers/aws/r/sns_topic.html#delivery_policy)
* [sns_topic_application_success_feedback_role_arn](https://www.terraform.io/docs/providers/aws/r/sns_topic.html#application_success_feedback_role_arn)
* [sns_topic_application_success_feedback_sample_rate](https://www.terraform.io/docs/providers/aws/r/sns_topic.html#application_success_feedback_sample_rate)
* [sns_topic_application_failure_feedback_role_arn](https://www.terraform.io/docs/providers/aws/r/sns_topic.html#application_failure_feedback_role_arn)
* [sns_topic_http_success_feedback_role_arn](https://www.terraform.io/docs/providers/aws/r/sns_topic.html#http_success_feedback_role_arn)
* [sns_topic_http_success_feedback_sample_rate](https://www.terraform.io/docs/providers/aws/r/sns_topic.html#http_success_feedback_sample_rate)
* [sns_topic_http_failure_feedback_role_arn](https://www.terraform.io/docs/providers/aws/r/sns_topic.html#http_failure_feedback_role_arn)
* [sns_topic_kms_master_key_id](https://www.terraform.io/docs/providers/aws/r/sns_topic.html#kms_master_key_id)
* [sns_topic_lambda_success_feedback_role_arn](https://www.terraform.io/docs/providers/aws/r/sns_topic.html#lambda_success_feedback_role_arn)
* [sns_topic_lambda_success_feedback_sample_rate](https://www.terraform.io/docs/providers/aws/r/sns_topic.html#lambda_success_feedback_sample_rate)
* [sns_topic_lambda_failure_feedback_role_arn](https://www.terraform.io/docs/providers/aws/r/sns_topic.html#lambda_failure_feedback_role_arn)
* [sns_topic_sqs_success_feedback_role_arn](https://www.terraform.io/docs/providers/aws/r/sns_topic.html#sqs_success_feedback_role_arn)
* [sns_topic_sqs_success_feedback_sample_rate](https://www.terraform.io/docs/providers/aws/r/sns_topic.html#sqs_success_feedback_sample_rate)
* [sns_topic_sqs_failure_feedback_role_arn](https://www.terraform.io/docs/providers/aws/r/sns_topic.html#sqs_failure_feedback_role_arn)

### CloudWatch Event Rule

* [event_rule_description](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html#description)
* [event_rule_name](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html#name)
* [event_rule_name_prefix](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html#name_prefix)
* [event_rule_role_arn](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html#role_arn)
* [event_rule_is_enabled](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html#is_enabled)

### CloudWatch Event Target

* [event_target_target_id](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#target_id)
* [event_target_input](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#input)
* [event_target_input_path](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#input_path)
* [event_target_role_arn](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#role_arn)
* [event_target_run_command_targets_key](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#key)
* [event_target_run_command_targets_values](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#values)
* [event_target_ecs_target_group](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#group)
* [event_target_ecs_target_launch_type](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#launch_type)
* [event_target_ecs_target_subnets](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#subnets)
* [event_target_ecs_target_security_groups](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#security_groups)
* [event_target_ecs_target_assign_public_ip](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#assign_public_ip)
* [event_target_ecs_target_platform_version](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#platform_version)
* [event_target_ecs_target_task_count](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#task_count)
* [event_target_ecs_target_task_definition_arn](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#task_definition_arn)
* [event_target_batch_target_job_definition](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#job_definition)
* [event_target_batch_target_job_name](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#job_name)
* [event_target_batch_target_array_size](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#array_size)
* [event_target_batch_target_job_attempts](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#job_attempts)
* [event_target_kinesis_target_partition_key_path](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#partition_key_path)
* [event_target_sqs_target_message_group_id](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#message_group_id)
* [event_target_input_transformer_input_paths](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#input_paths)
* [event_target_input_transformer_input_template](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#input_template)