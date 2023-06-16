resource "aws_api_gateway_resource" "resource_parent" {
  parent_id   = "${var.api_gateway_rest_api_root_resource_id}"
  rest_api_id = "${var.api_gateway_rest_api_id}"
  path_part   = "${var.resource_path}"
  count       = "${var.enable ? 1 : 0}"
}

resource "aws_api_gateway_resource" "resource" {
  parent_id   = "${aws_api_gateway_resource.resource_parent[0].id}"
  rest_api_id = "${var.api_gateway_rest_api_id}"
  path_part   = "{proxy+}"
  count       = "${var.enable ? 1 : 0}"
}