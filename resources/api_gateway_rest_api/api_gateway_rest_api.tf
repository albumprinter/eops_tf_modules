resource "aws_api_gateway_rest_api" "api" {
  count = var.provision == true ? 1 : 0
  
  # Required
  name = var.name 

  # Optional
  description = var.description 
  endpoint_configuration {
    types = var.endpoint_configuration_types
  }
  binary_media_types = var.binary_media_types
  minimum_compression_size = var.minimum_compression_size
  body = var.body
  policy = var.policy
  api_key_source = var.api_key_source
}