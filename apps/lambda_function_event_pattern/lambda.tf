resource "aws_lambda_function" "app" {
//  filename = "${var.filename}"
//  source_code_hash = "${base64sha256(file(${var.lambda_bucket_name}/builds/lambda/${var.app_name}.zip))}"
  s3_bucket = "${var.lambda_bucket_name}"
  //  s3_object_version = "$LATEST"
  s3_key = "builds/lambda/${var.app_name}/lambda.zip"
  function_name = "${var.app_name}"
  description = "${var.description}"
  role = "${aws_iam_role.iam_for_app.arn}"
  handler = "${var.handler}"
  runtime = "${var.runtime}"
  memory_size = "${var.memory_size}"
  timeout = "${var.timeout}"
  count = "${var.enabled}"

  environment {
    variables = "${var.lambda_env}"
  }
}

resource "aws_lambda_permission" "cloudwatch" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.app.arn}"
  principal = "events.amazonaws.com"
  source_arn = "${aws_cloudwatch_event_rule.app.arn}"
  count = "${var.enabled}"
}

resource "aws_iam_role" "iam_for_app" {
  name = "${var.app_name}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "iam_policy_for_app" {
  name = "${var.app_name}"
  role = "${aws_iam_role.iam_for_app.id}"
  policy = "${var.iam_policy_document}"
}

//resource "aws_lambda_alias" "app_alias" {
//  name = "${var.app_name}"
//  description = "${var.description}"
//  function_name = "${aws_lambda_function.app.arn}"
//  function_version = "$LATEST"
//}
