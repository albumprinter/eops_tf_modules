variable "region" {
  default = "eu-west-1"
}
variable "tags_business_unit" {
  default = "Albumprinter"
}
variable "account_type" {}
variable "tags_cost_center" {}
variable "tags_team" {}
variable "tags_domain" {}
variable "tags_purpose" {
  default = ""
}
variable "description" {}
variable "app_name" {}
variable "lambda_bucket_name" {}

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

variable "schedule_expression" {
  default = "rate(5 minutes)"
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
                "ec2:DescribeVpcs",
                "ec2:DescribeSubnets",
                "ec2:DescribeSecurityGroups",
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
                "lambda:*",
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

variable "lambda_memory_alert_threshold" {
  default = "120"
}

variable "alarm_action_arn" {
  default = ""
}

variable "retention_days" {
  default = "30"
}
variable "enable_cloudwatch_alarms" {
  default = "1"
}
