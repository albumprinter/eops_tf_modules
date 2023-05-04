resource "aws_api_gateway_integration" "integration" {
  http_method             = "${aws_api_gateway_method.method[0].http_method}"
  rest_api_id             = "${var.api_gateway_rest_api_id}"
  resource_id             = "${aws_api_gateway_resource.resource[0].id}"
  type                    = "${var.api_gateway_integration_type}"
  integration_http_method = "${var.api_gateway_integration_method}"
  uri                     = "${var.api_gateway_integration_uri}"
  credentials             = "${var.api_gateway_integration_credentials}"
  count                   = "${var.enable}"
}