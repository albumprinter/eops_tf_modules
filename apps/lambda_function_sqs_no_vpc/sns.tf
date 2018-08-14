resource "aws_sns_topic" "replay_sns" {
  name = "${var.app_name}-REPLAY"
}

resource "aws_sns_topic_subscription" "sqs_sns_topic_subscription" {
  topic_arn   = "${aws_sns_topic.replay_sns.arn}"
  protocol    = "sqs"
  endpoint    = "${aws_sqs_queue.sqs_queue.arn}"
}

resource "aws_sns_topic" "error_sns" {
  name = "${var.app_name}-ERROR"
}

resource "aws_sns_topic_subscription" "lambda_error_topic_sqs_subscription" {
  topic_arn = "${aws_sns_topic.error_sns.arn}"
  protocol  = "sqs"
  endpoint  = "${aws_sqs_queue.lambda_error_queue.arn}"
}
