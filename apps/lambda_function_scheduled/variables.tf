variable "region" {
  default = "eu-west-1"
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
}
variable "handler" {}
variable "environment" {}
variable "variables" {
  type = map(string)
  default = {
    env = ""
  }
}
variable "tracing_config" {
  default = "PassThrough"
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

variable "cloudwatch_event_rule_is_enabled" {
  default = true
}

variable "lambda_bucket_name" {
    default = ""
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
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterface"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

variable "reserved_concurrent_executions" {
  default = -1
}
