resource "aws_api_gateway_resource" "resource" {
  count = var.provision == true ? 1 : 0

  # Required
  rest_api_id = var.rest_api_id
  parent_id = var.parent_id 
  path_part = var.path_part 
}