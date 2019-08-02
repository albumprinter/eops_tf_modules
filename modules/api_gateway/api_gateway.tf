module "api_gateway_rest_api" {
  source = "../../resources/api_gateway_rest_api"
  provision = var.provision
  
  # Required
  name = var.api_gateway_rest_api_name

  #Optional
  description = var.api_gateway_rest_api_description
  endpoint_configuration_types = var.api_gateway_rest_api_endpoint_configuration_types
  binary_media_types = var.api_gateway_rest_api_binary_media_types
  minimum_compression_size = var.api_gateway_rest_api_minimum_compression_size
  body = var.api_gateway_rest_api_body
  policy = var.api_gateway_rest_api_policy
  api_key_source = var.api_gateway_rest_api_api_key_source
}

module "api_gateway_resource" {
  source = "../../resources/api_gateway_resource"
  provision = var.api_gateway_rest_api_name != null && var.api_gateway_resource_path_part != null ? true : false

  # Required
  rest_api_id = module.api_gateway_rest_api.api_id
  parent_id = module.api_gateway_rest_api.root_resource_id
  path_part = var.api_gateway_resource_path_part
}


module "api_gateway_method" {
  source = "../../resources/api_gateway_method"
  provision = var.provision
  
  # Required
  rest_api_id = module.api_gateway_rest_api.api_id
  resource_id = var.api_gateway_resource_path_part != null ? module.api_gateway_resource.resource_id : module.api_gateway_rest_api.root_resource_id
  http_method = var.api_gateway_method_http_method
  authorization = var.api_gateway_method_authorization

  # Optional
  authorizer_id = var.api_gateway_method_authorizer_id
  authorization_scopes = var.api_gateway_method_authorization_scopes
  api_key_required = var.api_gateway_method_api_key_required
  request_models = var.api_gateway_method_request_models
  request_validator_id = var.api_gateway_method_request_validator_id
  request_parameters = var.api_gateway_method_request_parameters
}

module "api_gateway_integration" {
  source = "../../resources/api_gateway_integration"
  provision = var.provision
  
  # Required
  rest_api_id = module.api_gateway_rest_api.api_id
  resource_id = var.api_gateway_resource_path_part != null ? module.api_gateway_resource.resource_id : module.api_gateway_rest_api.root_resource_id
  http_method = module.api_gateway_method.http_method
  type = var.api_gateway_integration_type

  # Optional
  integration_http_method = var.api_gateway_integration_integration_http_method
  connection_type = var.api_gateway_integration_connection_type
  connection_id = var.api_gateway_integration_connection_id
  uri = var.api_gateway_integration_uri
  credentials = var.api_gateway_integration_credentials
  request_templates = var.api_gateway_integration_request_templates
  request_parameters = var.api_gateway_integration_request_parameters
  passthrough_behavior = var.api_gateway_integration_passthrough_behavior
  cache_key_parameters = var.api_gateway_integration_cache_key_parameters
  cache_namespace = var.api_gateway_integration_cache_namespace
  content_handling = var.api_gateway_integration_content_handling
  timeout_milliseconds = var.api_gateway_integration_timeout_milliseconds
}

module "api_gateway_deployment" {
  source = "../../resources/api_gateway_deployment"
  provision = var.provision
  
  # Required
  rest_api_id = module.api_gateway_rest_api.api_id

  # Optional
  stage_name = var.api_gateway_deployment_stage_name != null ? var.api_gateway_deployment_stage_name : var.tag_environment
  description = var.api_gateway_deployment_description
  stage_description = var.api_gateway_deployment_stage_description
  #variables = var.api_gateway_deployment_variables
  variables = var.api_gateway_deployment_variables != null ? merge(var.api_gateway_deployment_variables, { "uri" = module.api_gateway_integration.uri }) : { "uri" = module.api_gateway_integration.uri } 
}