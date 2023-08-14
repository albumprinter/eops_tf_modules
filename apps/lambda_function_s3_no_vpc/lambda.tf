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
  dead_letter_config {
    target_arn = "${aws_sqs_queue.sqs_error_queue.arn}"
  }
  count                          = "${var.enabled}"
  tags                           = "${local.tags}"
  reserved_concurrent_executions = "${var.reserved_concurrent_executions}"
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

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.app[0].arn}"
  principal     = "s3.amazonaws.com"
  source_arn    = "${var.s3_bucket_arn}"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = "${var.s3_bucket_name}"

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.app[0].arn}"
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "${var.s3_filter_prefix}"
    filter_suffix       = "${var.s3_filter_suffix}"
  }
}