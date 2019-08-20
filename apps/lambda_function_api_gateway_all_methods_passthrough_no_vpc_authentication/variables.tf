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
  type = "map"
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

variable "response_template" {
  type = "map"
  default = {
    "application/json" = ""
  }
}

variable "lambda_memory_alert_threshold" {}
variable "alarm_action_arn" {}

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
                "sns:ListSubscriptions",
                "sns:ListSubscriptionsByTopic",
                "sns:ListTopics",
                "sns:Subscribe",
                "sns:Unsubscribe",
                "sns:Publish",
                "sqs:GetQueueUrl",
                "sqs:ListQueues",
                "sqs:SendMessage",
                "kms:ListAliases",
                "ec2:DescribeVpcs",
                "ec2:DescribeSubnets",
                "ec2:DescribeSecurityGroups",
                "iot:GetTopicRule",
                "iot:ListTopicRules",
                "iot:CreateTopicRule",
                "iot:ReplaceTopicRule",
                "iot:AttachPrincipalPolicy",
                "iot:AttachThingPrincipal",
                "iot:CreateKeysAndCertificate",
                "iot:CreatePolicy",
                "iot:CreateThing",
                "iot:ListPolicies",
                "iot:ListThings",
                "iot:DescribeEndpoint"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

variable "retention_days" {
  default = "30"
}

variable "binary_media_types" {
  default = ["application/octet-stream", "image/*"]
}

variable "swagger_resource_enable" {
  default = false
}

variable "swagger_resource_path" {
  default = "swagger"
}

variable "swagger_api_key_required" {
  default = false
}

variable "swagger_api_key" {
  default = ""
}

variable "api_gateway_type" {
  default = "EDGE"
}
variable "enable_cloudwatch_alarms" {
  default = 1
}
