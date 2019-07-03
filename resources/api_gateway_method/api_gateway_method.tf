resource "aws_api_gateway_method" "method" {
  count = var.provision == true ? 1 : 0
  
  # Required
  rest_api_id = var.rest_api_id 
  resource_id = var.resource_id
  http_method = var.http_method
  authorization = var.authorization

  # Optional
  authorizer_id = var.authorizer_id 
  authorization_scopes = var.authorization_scopes
  api_key_required = var.api_key_required
  request_models = var.request_models
  request_validator_id = var.request_validator_id
  request_parameters = var.request_parameters
}