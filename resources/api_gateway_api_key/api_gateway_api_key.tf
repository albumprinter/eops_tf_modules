resource "aws_api_gateway_api_key" "key" {
  count = var.provision == true ? 1 : 0

  # Required
  name = var.name 
  # Optional
  description = var.description
  enabled = var.enabled
  value = var.value
}