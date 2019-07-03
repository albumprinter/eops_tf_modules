output "api_id" {
  value = var.provision == true ? aws_api_gateway_rest_api.api[0].id : null
}

output "root_resource_id" {
  value = var.provision == true ? aws_api_gateway_rest_api.api[0].root_resource_id : null
}
