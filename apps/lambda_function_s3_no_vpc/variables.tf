variable "region" {
  default = "eu-west-1"
}
variable "account_type" {}
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
variable "handler" {}
variable "environment" {}
variable "variables" {
  type = map(string)
  default = {
    env = ""
  }
}

variable "lambda_bucket_name" {
  default = ""
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

variable "private" {
  default = false
}
variable "vpc_enabled" {
  default = true
}

variable "event_source_mapping_active" {
  default = true
}

variable "response_template" {
  type = map(string)
  default = {
    "application/json" = ""
  }
}

variable "iam_policy_document" {
  default = <<EOF
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

variable "lambda_memory_alert_threshold" {
  default = "120"
}

variable "redrive_policy_retry_count" {
  default = "3"
}

variable "alarm_action_arn" {
  default = ""
}
variable "retention_days" {
  default = "30"
}
variable "reserved_concurrent_executions" {
  default = -1
}
variable "visibility_timeout_seconds" {
  default = 60
}
variable "receive_wait_time_seconds" {
  default = "20"
}
variable "message_retention_seconds" {
  default = "1209600"
}
variable "enable_cloudwatch_alarms" {
  default = 1
}

variable "tracing_config" {
  default = "PassThrough"
}

variable "s3_bucket_arn" {
  default = ""
}

variable "s3_bucket_name" {
  default = ""
}

variable "s3_filter_prefix" {
  default = ""
}

variable "s3_filter_suffix" {
  default = ""
}