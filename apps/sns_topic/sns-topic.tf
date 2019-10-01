resource "aws_sns_topic" "sns-topic" {
  name =  "${var.app_name}"
  tags =  "${local.tags}"
  count = "${var.enabled}"
}

locals {
  default_policy_doc = <<POLICY
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
  iam_policy_doc = "${var.iam_policy_document == "" ? local.default_policy_doc : var.iam_policy_document}"
}

resource "aws_sns_topic_policy" "default" {
  arn = "${aws_sns_topic.sns-topic.arn}"

  policy = "${local.iam_policy_doc}"
}