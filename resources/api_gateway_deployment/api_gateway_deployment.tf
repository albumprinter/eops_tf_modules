resource "aws_api_gateway_deployment" "deployment" {
  count = var.provision == true ? 1 : 0
  
  # Required
  rest_api_id = var.rest_api_id

  # Optional
  stage_name = var.stage_name
  description = var.description
  stage_description = var.stage_description
  variables = var.variables 
}