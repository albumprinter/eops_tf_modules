output "lambda_arn" {
  value = "${aws_lambda_function.app.arn}"
}

output "iam_role_arn" {
  value = "${aws_iam_role.iam_for_app.arn}"
}