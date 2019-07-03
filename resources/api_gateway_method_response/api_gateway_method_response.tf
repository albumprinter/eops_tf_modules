resource "aws_api_gateway_method_response" "response" {
  count = var.provision == true ? 1 : 0

  # Required
  rest_api_id = var.rest_api_id
  resource_id = var.resource_id
  http_method = var.http_method
  status_code = var.status_code

  # Optional
  response_models = var.response_models
  response_parameters  = var.response_parameters
}