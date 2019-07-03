output "http_method" {
  value = var.provision == true ? aws_api_gateway_method.method[0].http_method : ""
}
