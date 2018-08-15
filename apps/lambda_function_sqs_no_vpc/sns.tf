resource "aws_sns_topic" "replay_sns" {
  name = "${var.sqs_name}-REPLAY"
}

resource "aws_sns_topic_subscription" "sqs_sns_topic_subscription" {
  topic_arn   = "${aws_sns_topic.replay_sns.arn}"
  protocol    = "sqs"
  endpoint    = "${aws_sqs_queue.sqs_queue.arn}"
}

