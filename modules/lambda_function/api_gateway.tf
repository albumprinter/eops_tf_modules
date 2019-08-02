module "api_gateway" {
  source = "../api_gateway"
  provision = var.api_gateway_rest_api_name != null ? true : false

  # Required
  api_gateway_rest_api_name = var.api_gateway_rest_api_name
   #Optional
  api_gateway_rest_api_description = var.api_gateway_rest_api_description
  api_gateway_rest_api_endpoint_configuration_types = var.api_gateway_rest_api_endpoint_configuration_types
  api_gateway_rest_api_binary_media_types = var.api_gateway_rest_api_binary_media_types
  api_gateway_rest_api_minimum_compression_size = var.api_gateway_rest_api_minimum_compression_size
  api_gateway_rest_api_body = var.api_gateway_rest_api_body
  api_gateway_rest_api_policy = var.api_gateway_rest_api_policy
  api_gateway_rest_api_api_key_source = var.api_gateway_rest_api_api_key_source

  # Required
  api_gateway_resource_path_part = var.api_gateway_resource_path_part

  # Required
  api_gateway_method_http_method = var.api_gateway_method_http_method
  api_gateway_method_authorization = var.api_gateway_method_authorization
  # Optional
  api_gateway_method_authorizer_id = var.api_gateway_method_authorizer_id
  api_gateway_method_authorization_scopes = var.api_gateway_method_authorization_scopes
  api_gateway_method_api_key_required = var.api_gateway_method_api_key_required
  api_gateway_method_request_models = var.api_gateway_method_request_models
  api_gateway_method_request_validator_id = var.api_gateway_method_request_validator_id
  api_gateway_method_request_parameters = var.api_gateway_method_request_parameters

  # Required
  api_gateway_integration_type = var.api_gateway_integration_type
  # Optional
  api_gateway_integration_integration_http_method = var.api_gateway_integration_integration_http_method
  api_gateway_integration_connection_type = var.api_gateway_integration_connection_type
  api_gateway_integration_connection_id = var.api_gateway_integration_connection_id
  api_gateway_integration_uri = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${module.lambda_function.function_arn}/invocations"
  api_gateway_integration_credentials = var.api_gateway_integration_credentials
  api_gateway_integration_request_templates = var.api_gateway_integration_request_templates
  api_gateway_integration_request_parameters = var.api_gateway_integration_request_parameters
  api_gateway_integration_passthrough_behavior = var.api_gateway_integration_passthrough_behavior
  api_gateway_integration_cache_key_parameters = var.api_gateway_integration_cache_key_parameters
  api_gateway_integration_cache_namespace = var.api_gateway_integration_cache_namespace
  api_gateway_integration_content_handling = var.api_gateway_integration_content_handling
  api_gateway_integration_timeout_milliseconds = var.api_gateway_integration_timeout_milliseconds

  # Optional
  api_gateway_deployment_stage_name = var.api_gateway_deployment_stage_name != null ? var.api_gateway_deployment_stage_name : var.tag_environment
  api_gateway_deployment_description = var.api_gateway_deployment_description
  api_gateway_deployment_stage_description = var.api_gateway_deployment_stage_description
  api_gateway_deployment_variables = var.api_gateway_deployment_variables

  tag_environment = var.tag_environment
  tag_cost_center = var.tag_cost_center
  tag_domain = var.tag_domain
}



module "api_gateway_lambda_permission" {
  source  = "../../resources/lambda_permission"
  provision = var.api_gateway_rest_api_name != null ? true : false

  # Required
  action = var.lambda_permission_action
  function_name = "${var.function_name}"
  principal = "apigateway.amazonaws.com"

  # Optional
  event_source_token = var.lambda_permission_event_source_token
  qualifier = var.lambda_permission_qualifier
  source_account = var.lambda_permission_source_account
  source_arn = var.lambda_permission_source_arn
  statement_id = var.lambda_permission_statement_id
  statement_id_prefix = var.lambda_permission_statement_id_prefix
}
