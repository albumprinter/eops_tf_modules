resource "aws_sns_topic" "sns-topic" {
  name = "${var.app_name}"
  tags = "${local.tags}"
}

resource "aws_sns_topic_policy" "default" {
  arn = "${aws_sns_topic.sns-topic.arn}"

  policy = "${local.iam_policy_document}"
}