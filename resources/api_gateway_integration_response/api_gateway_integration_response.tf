resource "aws_api_gateway_integration_response" "response" {
  count = var.provision == true ? 1 : 0

  # Required
  rest_api_id = var.rest_api_id
  resource_id = var.resource_id
  http_method = var.http_method
  status_code = var.status_code

  # Optional
  selection_pattern = var.selection_pattern
  response_templates = var.response_templates
  response_parameters = var.response_parameters
  content_handling = var.content_handling
}