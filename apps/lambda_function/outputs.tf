output "lambda_arn" {
  value = "${aws_lambda_function.app[*].arn}"
}

output "lambda_name" {
  value = "${aws_lambda_function.app[*].function_name}"
}

output "iam_role_arn" {
  value = "${aws_iam_role.iam_for_app.arn}"
}

output "invokation_arn" {
  value = "${aws_lambda_function.app[*].invoke_arn}"
}

output "authorization_arn" {
  value = "${aws_lambda_function.app[*].arn}"
}