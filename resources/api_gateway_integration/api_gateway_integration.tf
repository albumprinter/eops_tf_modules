resource "aws_api_gateway_integration" "integration" {
  count = var.provision == true ? 1 : 0
  
  # Required
  rest_api_id = var.rest_api_id
  resource_id = var.resource_id
  http_method = var.http_method
  type = var.type

  # Optional
  integration_http_method = var.integration_http_method
  connection_type = var.connection_type 
  connection_id = var.connection_id
  uri = var.uri 
  credentials = var.credentials
  request_templates = var.request_templates
  request_parameters = var.request_parameters
  passthrough_behavior = var.passthrough_behavior 
  cache_key_parameters = var.cache_key_parameters
  cache_namespace = var.cache_namespace
  content_handling = var.content_handling 
  timeout_milliseconds = var.timeout_milliseconds
}