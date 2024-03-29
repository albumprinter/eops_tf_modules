output "security_group_id" {
  value = "${aws_security_group.sg_for_app.id}"
}

output "api_gateway_rest_api_id" {
  value = "${aws_api_gateway_rest_api.app.id}"
}

output "api_gateway_resource_app_id" {
  value = "${aws_api_gateway_resource.app.id}"
}

output "lambda_kms_key_id" {
  value = "${aws_lambda_function.app.*.id}"
}

output "lambda_arn" {
  value = "${aws_lambda_function.app.*.arn}"
}

output "proxy_api_lambda_passthru_gateway_endpoint" {
  value = "https://${aws_api_gateway_deployment.app.rest_api_id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_deployment.app.stage_name}"
}

output "iam_role_arn" {
  value = "${aws_iam_role.iam_for_app.arn}"
}

output "id" {
  value = "${aws_lambda_function.app.0.id}"
}
output "arn" {
  value = "${aws_lambda_function.app.0.arn}"
}
output "version" {
  value = "${aws_lambda_function.app.0.version}"
}
output "function_name" {
  value = "${aws_lambda_function.app.0.function_name}"
}
output "name" {
  value = "${var.useAlias ? aws_lambda_alias.alias.name : aws_lambda_function.app.0.function_name}"
}