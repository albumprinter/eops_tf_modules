# Description

An example terraform module to build simple application as aws lambda function triggered by SNS - hosted ont eh shared VPC.

## Code Example

```hcl-terraform

//CustomerSubscription.EmailChanged
module "lambda_app" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//apps/lambda_function_sns?ref=v0.17.10" # for eg. {TAG_VERSION} = v0.17.10
  app_name = "${var.lambda_name}"
  description = "Lambda function to process SNS"
  handler = "Lambda::Lambda.Handler::Handle"
  environment = "${var.environment}"
  runtime = "dotnetcore2.1"
  memory_size = "${var.memory}"
  timeout = "30" // optional
  tags_team = "WATSON"
  lambda_bucket_name = "${var.lambda_bucket_name}"
  lambda_sns_subscription_arn = "arn:aws:sns:eu-west-1:179698508378:Albumprinter-Authentication-Messaging-Messages-V1-EmailChanged"
  variables = {
    dummy = ""
  }
  iam_policy_document = "${data.aws_iam_policy_document.policy.json}"
}

data "aws_iam_policy_document" "policy" {
  statement {
    actions   = [
                "logs:CreateLogStream",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents",
                "logs:GetLogEvents"
               ]
    resources = ["arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.lambda_name}:*"]
  }
  statement {
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface"
    ]
    resources = ["arn:aws:ec2:${var.region}:*"]
  }
}


```
