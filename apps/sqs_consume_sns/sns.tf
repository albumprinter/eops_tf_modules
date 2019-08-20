resource "aws_sns_topic" "replay_sns" {
  name = "${var.app_name}-REPLAY"
}

resource "aws_sns_topic_subscription" "replay_topic_subscription" {
  topic_arn = "${aws_sns_topic.replay_sns.arn}"
  protocol  = "sqs"
  endpoint  = "${aws_sqs_queue.sqs_queue.arn}"
}

resource "aws_sns_topic_subscription" "sqs_event_topic_subscription" {
  topic_arn     = "${var.sns_subscription_arn}"
  protocol      = "sqs"
  endpoint      = "${aws_sqs_queue.sqs_queue.arn}"
  filter_policy = "${var.sns_subscription_filters}"
}
