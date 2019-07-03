# Module: Lambda Function

This module makes it possible to provision the following resources:

* Lambda Function
* IAM Role for the function
* CloudWatch Log Group for the function with a default retention period of 30 days
* Dead letter mechanism that can be either a SQS Queue (default) or a SNS Topic
* (**Optional**) CloudWatch Rule (scheduled or event pattern) to trigger the function
* (**Optional**) API Gateway integrated with the function

## Examples 

These are some examples of how this module can be used. For more, please check this [examples file](../../examples/lambda_function/main.tf).

#### Minimal configuration
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

#### VPC access
```
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
```

#### Scheduled Event Rule
```
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
```


#### API Gateway Integration
```
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
```

## Required parameters

The following parameters are considered required.

#### Shared by all resources

Following the [albelli tagging standard](https://wiki.albelli.net/wiki/Albelli_AWS_Tagging_standards), the following parameters are required and will be applied to all taggable resources.

* **tag_environment**
* **tag_cost_center**
* **tag_domain**

#### Lambda Function

These are the required parameters to create a Lambda function:

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

## Optional parameters

In order to make this module as flexbile as possible, the following parameters are also exposed and can be combine in any way **accepted by AWS**.

They follow the same name as in the offical Terraform documentation with the addition of a prefix (e.g. *function_*) to identify to which resource does the parameter belong to.

#### Shared by all resources

* **tag_others**: map containing any extra tags that should be added to the resources except for the required tags.
  * Note: The tag `name` shouldn't be used in this map, otherwise all resources will be tagged with the same value.

------

#### Lambda Function

* **function_dead_letter_target_type**: this a custom string parameter that indicates which type of dead letter mechanism should be used. Valid values are `SNS` or `SQS`, being `SQS` the default one.
* **function_dead_letter_target_name**: this a custom string parameter that indicates the name for the dead letter mechanism (either a topic or a queue). If not passed, the default name will be either `"${var.function_name}_dead_letter_queue"` or `"${var.function_name}_dead_letter_topic"`
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

------

#### IAM Role

* **iam_role_policy_statements**: IAM policy statements granting permissions to the function.
  * Note: The [basic permissions](lambda_function.tf#L37) to write log messages, send dead letter information, and manage VPC interfaces (if applicable) will be granted automatically and don't need to be listed here. 
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

------

#### CloudWatch Log Group

* [log_group_retention_in_days](https://www.terraform.io/docs/providers/aws/r/cloudwatch_log_group.html#retention_in_days)
  * Note: by default, uses the value `30` if not specified
* [log_group_kms_key_id](https://www.terraform.io/docs/providers/aws/r/cloudwatch_log_group.html#kms_key_id)

------

#### Dead Letter SQS Queue

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

------

#### Dead Letter SNS Topic (Optional)

This resource **will be created only if** `function_dead_letter_target_type` is set to `SNS`. If so, the default resource *Dead Letter SQS Queue* won't be created.

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

------

#### CloudWatch Event Rule (Optional)

This resource **will be created only if** either `event_rule_event_pattern` or `event_rule_schedule_expression` is configured. If so, there are required and optional parameters as described below.

##### Required
* [event_rule_event_pattern](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html#event_pattern)
  * Note: Required, if `event_rule_schedule_expression` isn't specified
* [event_rule_schedule_expression](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html#schedule_expression)
  * Note: Required, if `event_rule_event_pattern` isn't specified

##### Optional

* [event_rule_description](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html#description)
* [event_rule_name](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html#name)
* [event_rule_name_prefix](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html#name_prefix)
* [event_rule_role_arn](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html#role_arn)
* [event_rule_is_enabled](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html#is_enabled)

------

#### CloudWatch Event Target (Optional)

This resource **will be created only if** a `CloudWatch Event Rule` is configured.

* [event_target_target_id](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#target_id)
* [event_target_input](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#input)
* [event_target_input_path](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#input_path)
* [event_target_role_arn](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#role_arn)
* [event_target_input_transformer_input_paths](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#input_paths)
* [event_target_input_transformer_input_template](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html#input_template)

------

#### API Gateway REST API (Optional)

This resource **will be created only if** `api_gateway_rest_api_name` is configured. If so, there are required and optional parameters as described below.

##### Required
* [api_gateway_rest_api_name](https://www.terraform.io/docs/providers/aws/r/api_gateway_rest_api.html#name)

##### Optional

* [api_gateway_rest_api_description](https://www.terraform.io/docs/providers/aws/r/api_gateway_rest_api.html#description)
* [api_gateway_rest_api_endpoint_configuration_types](https://www.terraform.io/docs/providers/aws/r/api_gateway_rest_api.html#types)
  * Note: by default, uses the value `EDGE` if not specified
* [api_gateway_rest_api_binary_media_types](https://www.terraform.io/docs/providers/aws/r/api_gateway_rest_api.html#binary_media_types)
* [api_gateway_rest_api_minimum_compression_size](https://www.terraform.io/docs/providers/aws/r/api_gateway_rest_api.html#minimum_compression_size)
* [api_gateway_rest_api_body](https://www.terraform.io/docs/providers/aws/r/api_gateway_rest_api.html#body)
* [api_gateway_rest_api_policy](https://www.terraform.io/docs/providers/aws/r/api_gateway_rest_api.html#policy)
* [api_gateway_rest_api_api_key_source](https://www.terraform.io/docs/providers/aws/r/api_gateway_rest_api.html#api_key_source)

------

#### API Gateway REST Resource (Optional)

This resource **will be created only if** a `API Gateway REST API` is configured and `api_gateway_resource_path_part` is set. Otherwise, the default resource from the API Gateway REST API will be used to create any related resources.

* [api_gateway_resource_path_part](https://www.terraform.io/docs/providers/aws/r/api_gateway_resource.html#path_part)

------

#### API Gateway REST Method (Optional)

This resource **will be created only if** `api_gateway_rest_api_name` is configured. If so, there are required and optional parameters as described below.

##### Required
* [api_gateway_method_http_method](https://www.terraform.io/docs/providers/aws/r/api_gateway_method.html#http_method)
  * Note: by default, uses the value `ANY` if not specified
* [api_gateway_method_authorization](https://www.terraform.io/docs/providers/aws/r/api_gateway_method.html#authorization)
  * Note: by default, uses the value `NONE` if not specified

##### Optional
* [api_gateway_method_authorizer_id](https://www.terraform.io/docs/providers/aws/r/api_gateway_method.html#authorizer_id)
* [api_gateway_method_authorization_scopes](https://www.terraform.io/docs/providers/aws/r/api_gateway_method.html#authorization_scopes)
* [api_gateway_method_api_key_required](https://www.terraform.io/docs/providers/aws/r/api_gateway_method.html#api_key_required)
* [api_gateway_method_request_models](https://www.terraform.io/docs/providers/aws/r/api_gateway_method.html#request_models)
* [api_gateway_method_request_validator_id](https://www.terraform.io/docs/providers/aws/r/api_gateway_method.html#request_validator_id)
* [api_gateway_method_request_parameters](https://www.terraform.io/docs/providers/aws/r/api_gateway_method.html#request_parameters)

------

#### API Gateway Integration (Optional)

This resource **will be created only if** `api_gateway_rest_api_name` is configured. If so, there are required and optional parameters as described below.

##### Required
* [api_gateway_integration_http_method](https://www.terraform.io/docs/providers/aws/r/api_gateway_integration.html#http_method)
  * Note: by default, uses the value `ANY` if not specified
* [api_gateway_integration_type](https://www.terraform.io/docs/providers/aws/r/api_gateway_integration.html#type)
  * Note: by default, uses the value `AWS_PROXY` if not specified

##### Optional
* [api_gateway_integration_integration_http_method](https://www.terraform.io/docs/providers/aws/r/api_gateway_integration.html#integration_http_method)
  * Note: by default, uses the value `POST` if not specified
* [api_gateway_integration_connection_type](https://www.terraform.io/docs/providers/aws/r/api_gateway_integration.html#connection_type)
* [api_gateway_integration_connection_id](https://www.terraform.io/docs/providers/aws/r/api_gateway_integration.html#connection_id)
* [api_gateway_integration_uri](https://www.terraform.io/docs/providers/aws/r/api_gateway_integration.html#uri)
  * Note: by default, uses the value `arn:aws:apigateway:{REGION}:lambda:path/2015-03-31/functions/{LAMBDA_FUNCTION_ARN}/invocations` if not specified
* [api_gateway_integration_credentials](https://www.terraform.io/docs/providers/aws/r/api_gateway_integration.html#credentials)
* [api_gateway_integration_request_templates](https://www.terraform.io/docs/providers/aws/r/api_gateway_integration.html#request_templates)
* [api_gateway_integration_request_parameters](https://www.terraform.io/docs/providers/aws/r/api_gateway_integration.html#request_parameters)
* [api_gateway_integration_passthrough_behavior](https://www.terraform.io/docs/providers/aws/r/api_gateway_integration.html#passthrough_behavior)
* [api_gateway_integration_cache_key_parameters](https://www.terraform.io/docs/providers/aws/r/api_gateway_integration.html#cache_key_parameters)
* [api_gateway_integration_cache_namespace](https://www.terraform.io/docs/providers/aws/r/api_gateway_integration.html#cache_namespace)
* [api_gateway_integration_content_handling](https://www.terraform.io/docs/providers/aws/r/api_gateway_integration.html#content_handling)
* [api_gateway_integration_timeout_milliseconds](https://www.terraform.io/docs/providers/aws/r/api_gateway_integration.html#timeout_milliseconds)

------

#### API Gateway Deployment (Optional)

This resource **will be created only if** `api_gateway_rest_api_name` is configured.

* [api_gateway_deployment_stage_name](https://www.terraform.io/docs/providers/aws/r/api_gateway_deployment.html#stage_name)
  * Note: by default, uses the value provided for the variable `tag_environment` if not specified
* [api_gateway_deployment_description](https://www.terraform.io/docs/providers/aws/r/api_gateway_deployment.html#description)
* [api_gateway_deployment_stage_description](https://www.terraform.io/docs/providers/aws/r/api_gateway_deployment.html#stage_description)
* [api_gateway_deployment_variables](https://www.terraform.io/docs/providers/aws/r/api_gateway_deployment.html#variables)