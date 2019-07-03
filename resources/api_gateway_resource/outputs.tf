output "resource_id" {
  value = var.provision == true ? aws_api_gateway_resource.resource[0].id : ""
}
