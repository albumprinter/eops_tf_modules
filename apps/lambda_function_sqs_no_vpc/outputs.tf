output "lambda_arn" {
  value = "${aws_lambda_function.app.*.arn}"
}

output "sqs_queue_arn" {
  value = "${aws_sqs_queue.sqs_queue.arn}"
}