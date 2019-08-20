resource "aws_sns_topic" "sns-topic" {
  name = "${var.app_name}"
}

resource "aws_sns_topic_policy" "default" {
  arn = "${aws_sns_topic.sns-topic.arn}"

  policy = <<POLICY
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
