variable "region" {
  default = "eu-west-1"
}
variable "account_type" {
  default = "sandbox"
}
variable "tags_business_unit" {
  default = "Albumprinter"
}

variable "path_part" {
  default = "{proxy+}"
}
variable "tags_cost_center" {
  default = "CC443100"
}
variable "tags_team" {}
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
  default ={
    "application/json" = ""
  }
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
                "sns:ListSubscriptions",
                "sns:ListSubscriptionsByTopic",
                "sns:ListTopics",
                "sns:Subscribe",
                "sns:Unsubscribe",
                "sns:Publish",
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