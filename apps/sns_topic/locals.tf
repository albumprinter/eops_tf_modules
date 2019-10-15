locals {
  tags = {
    Domain          = "${var.tags_domain}"
    Name            = "${var.app_name}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
  }
  iam_policy_document = <<POLICY
  {
    "Version": "2012-10-17",
    "Id": "${var.app_name}-policy",
    "Statement": [
      {
        "Sid": "Default",
        "Effect": "Allow",
        "Principal": {
          "AWS": "*"
        },
        "Action": [
          "SNS:Subscribe",
          "SNS:SetTopicAttributes",
          "SNS:RemovePermission",
          "SNS:Receive",
          "SNS:Publish",
          "SNS:ListSubscriptionsByTopic",
          "SNS:GetTopicAttributes",
          "SNS:DeleteTopic",
          "SNS:AddPermission"],
        "Resource": "${aws_sns_topic.sns-topic.arn}"
      }${var.sns_extra_policy_statements}
    ]
  }
  POLICY
}