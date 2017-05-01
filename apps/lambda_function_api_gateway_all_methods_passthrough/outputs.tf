output "security_group_id" {
  value = "${aws_security_group.sg_for_app.id}"
}
output "api_gateway_rest_api_id" {
  value = "${aws_api_gateway_rest_api.app.id}"
}
output "lambda_kms_key_id" {
  value = "${aws_lambda_function.app.id}"
}
output "lambda_arn" {
  value = "${aws_lambda_function.app.arn}"
}
output "lambda_kms_key_arn" {
  value = "${aws_lambda_function.app.kms_key_arn}"
}
output "proxy_api_lambda_passthru_gateway_endpoint" {
  value = "https://${aws_api_gateway_deployment.app.rest_api_id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_deployment.app.stage_name}"
}
output "iam_role_arn" {
  value = "${aws_iam_role.iam_for_app.arn}"
}