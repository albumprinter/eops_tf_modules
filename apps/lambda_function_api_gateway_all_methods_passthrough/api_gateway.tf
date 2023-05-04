
resource "aws_api_gateway_rest_api" "app" {
  name        = "${var.app_name}"
  description = "${var.description}"
  binary_media_types = "${var.binary_media_types}"
  endpoint_configuration {
    types = ["${var.api_gateway_type}"]
  }
}

resource "aws_api_gateway_resource" "app" {
  parent_id   = "${aws_api_gateway_rest_api.app.root_resource_id}"
  rest_api_id = "${aws_api_gateway_rest_api.app.id}"
  path_part   = "${var.path_part}"
}

resource "aws_api_gateway_method" "app" {
  rest_api_id = "${aws_api_gateway_rest_api.app.id}"
  resource_id = "${aws_api_gateway_resource.app.id}"
  http_method = "ANY"
  authorization = "NONE"
  request_parameters {
    //    "method.request.path.accountId" = true
  }
}

resource "aws_api_gateway_method_response" "ok" {
  rest_api_id = "${aws_api_gateway_rest_api.app.id}"
  resource_id = "${aws_api_gateway_resource.app.id}"
  http_method = "${aws_api_gateway_method.app.http_method}"
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_deployment" "app" {
  depends_on  = ["aws_api_gateway_integration.app_integration"]
  rest_api_id = "${aws_api_gateway_rest_api.app.id}"
  stage_name  = "Prod"
}

resource "aws_api_gateway_integration" "app_integration" {
  http_method = "${aws_api_gateway_method.app.http_method}"
  rest_api_id = "${aws_api_gateway_rest_api.app.id}"
  resource_id = "${aws_api_gateway_resource.app.id}"
  type = "AWS_PROXY"
  integration_http_method = "POST"
//  integration_http_method = "${aws_api_gateway_method.app.http_method}"
  uri = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${aws_lambda_function.app.arn}/invocations"

  credentials = "${aws_iam_role.iam_for_app.arn}"
}

resource "aws_api_gateway_integration_response" "app_integration_response" {
  depends_on  = ["aws_api_gateway_integration.app_integration"]
  rest_api_id = "${aws_api_gateway_rest_api.app.id}"
  resource_id = "${aws_api_gateway_resource.app.id}"
  http_method = "${aws_api_gateway_method.app.http_method}"
  status_code = "${aws_api_gateway_method_response.200.status_code}"

  response_templates = "${var.response_template}"
}


resource "aws_lambda_permission" "allow-api-gateway-parent-resource-get" {
  function_name = "${aws_lambda_function.app.id}"
  statement_id = "allow-api-gateway-parent-resource-get"
  action = "lambda:InvokeFunction"
  principal = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.region}:${module.aws_core_data.account_id}:${aws_api_gateway_rest_api.app.id}/*/${aws_api_gateway_method.app.http_method}${aws_api_gateway_resource.app.path}"
}
