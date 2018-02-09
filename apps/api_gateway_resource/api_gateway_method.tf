resource "aws_api_gateway_method" "method" {
  rest_api_id      = "${var.api_gateway_rest_api_id}"
  resource_id      = "${aws_api_gateway_resource.resource.id}"
  http_method      = "${var.resource_http_method}"
  authorization    = "${var.authorization}"
  api_key_required = "${var.api_key_required}" 
  count            = "${var.enable}"
}