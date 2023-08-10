module "lambda_s3_bucket_object" {
  source = "../../apps/lambda_s3_bucket_object"
  lambda_bucket_name = "${var.lambda_bucket_name}"
  s3_object_key = "builds/lambda/${var.app_name}/lambda.zip"
  tags = "${local.tags}"
  providers = {
   aws = "aws"
  } 
}

resource "aws_lambda_function" "app" {
  s3_bucket = "${var.lambda_bucket_name}"
  s3_key = "${module.lambda_s3_bucket_object.key}"
  function_name = "${var.app_name}"
  description   = "${var.description}"
  role          = "${aws_iam_role.iam_for_app.arn}"
  handler       = "${var.handler}"
  runtime       = "${var.runtime}"
  memory_size   = "${var.memory_size}"
  timeout       = "${var.timeout}"
  environment {
    variables = "${var.variables}"
  }
  tracing_config {
    mode = "${var.tracing_config}"
  }
  count                          = "${var.enabled}"
  tags                           = "${local.tags}"
  reserved_concurrent_executions = "${var.reserved_concurrent_executions}"
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  batch_size       = 1
  event_source_arn = "${aws_sqs_queue.sqs_queue.arn}"
  function_name    = "${aws_lambda_function.app[0].arn}"
  enabled          =  tobool(var.event_source_mapping_active > 0 ? "true" : "false")
}

resource "aws_iam_role" "iam_for_app" {
  name               = "${var.app_name}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "1",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    },
    {
      "Sid": "2",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Effect": "Allow"
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
