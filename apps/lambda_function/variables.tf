variable "region" {
  default = "eu-west-1"
}
variable "account_type" {
  default = "sandbox"
}
variable "tags_business_unit" {
  default = "Albumprinter"
}
variable "tags_cost_center" {}
variable "tags_team" {}
variable "tags_domain" {}
variable "tags_purpose" {
  default = ""
}
variable "description" {}
variable "app_name" {}

variable "runtime" {
  default = "nodejs4.3"
}
variable "handler" {
  default = "exports.handler"
}

variable "lambda_bucket_name" {}

variable "environment" {}
variable "variables" {
  type = map(string)
  default = {
    ENCODING="utf-8"
//    SUMO_ENDPOINT=""
//    SOURCE_CATEGORY_OVERRIDE=""
//    SOURCE_HOST_OVERRIDE=""
//    SOURCE_NAME_OVERRIDE=""
  }
}

variable "memory_size" {
  default = "128"
}
variable "timeout" {
  default = "3"
}
variable "enabled" {
  default = 1
}

variable "iam_policy_document" {
  default =<<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "ec2:CreateNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DeleteNetworkInterface",
                "cloudwatch:*",
                "cognito-identity:ListIdentityPools",
                "cognito-sync:GetCognitoEvents",
                "cognito-sync:SetCognitoEvents",
                "dynamodb:*",
                "events:*",
                "iam:ListAttachedRolePolicies",
                "iam:ListRolePolicies",
                "iam:ListRoles",
                "iam:PassRole",
                "kinesis:DescribeStream",
                "kinesis:ListStreams",
                "kinesis:PutRecord",
                "lambda:*",
                "logs:*",
                "s3:*",
                "sns:*",
                "sqs:*",
                "kms:ListAliases",
                "ec2:DescribeVpcs",
                "ec2:DescribeSubnets",
                "ec2:DescribeSecurityGroups",
                "xray:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

variable "assume_role_policy_document" {
  default =<<EOF
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

variable "retention_days" {
  default = "30"
}
variable "lambda_memory_alert_threshold" {
  default = "120"
}

variable "alarm_action_arn" {
  default = ""
}
variable "enable_cloudwatch_alarms" {
  default = 1
}
variable "reserved_concurrent_executions" {
  default = -1
}