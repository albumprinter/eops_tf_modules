data "archive_file" "dummyfile" {
  type        = "zip"
  output_path = "lambda.zip"
  source {
    content  = "1"
    filename = "dummyfile.txt"
  }
}

resource "aws_s3_bucket_object" "initialDummyContent" {
  bucket = "${var.lambda_bucket_name}"
  key    = "builds/lambda/${var.app_name}/lambda.zip"
  source = "lambda.zip"
  lifecycle {
    ignore_changes = "all"
  },
  tags = "${local.tags}"
}

resource "aws_lambda_function" "app" {
  s3_bucket = "${var.lambda_bucket_name}"
  s3_key = "${aws_s3_bucket_object.initialDummyContent.key}"
  function_name = "${var.app_name}"
  description = "${var.description}"
  role = "${aws_iam_role.iam_for_app.arn}"
  handler = "${var.handler}"
  runtime = "${var.runtime}"
  memory_size = "${var.memory_size}"
  timeout = "${var.timeout}"
  environment {
    variables = "${var.variables}"
  }
  count            = "${var.enabled}"
  tags = "${local.tags}"
}

resource "aws_iam_role" "iam_for_app" {
  name = "${var.app_name}"
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

resource "aws_security_group" "sg_for_app" {
  name = "${var.app_name}"
  description = "Allow all inbound traffic for the scheduled lambda function"
  vpc_id = "${module.aws_core_data.vpc_id}"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "185.184.204.70/32",
      "62.97.245.10/32",
      "185.184.204.74/32",
      "62.102.226.22/32",
      "213.41.124.76/32",
      "77.60.83.148/32",
      "62.21.226.193/32",
      "192.168.0.0/16",
      "10.0.0.0/8",
      "172.16.0.0/12"
    ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${local.tags}"
}