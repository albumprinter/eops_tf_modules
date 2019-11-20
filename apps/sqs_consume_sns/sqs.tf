resource "aws_sqs_queue_policy" "sqs_sns_policy" {
  queue_url = "${aws_sqs_queue.sqs_queue.id}"
  policy = "${local.iam_policy_document}"
}

resource "aws_sqs_queue" "sqs_error_queue" {
  name = "${var.app_name}-ERROR"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "sqs_queue" {
  name                       = "${var.app_name}"
  message_retention_seconds  = "${var.message_retention_seconds}"
  receive_wait_time_seconds  = "${var.receive_wait_time_seconds}"
  visibility_timeout_seconds = "${var.visibility_timeout_seconds}"
  redrive_policy             = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.sqs_error_queue.arn}\",\"maxReceiveCount\":${var.redrive_policy_retry_count}}"
  tags = {
    "Domain"         = "${var.tags_domain}"
    "Business Unit" = "${var.tags_business_unit}"
    "Environment"     = "${var.environment}"
    "Cost Center"   = "${var.tags_cost_center}"
    "Team"            = "${var.tags_team}"
    "Purpose"         = "${var.tags_purpose}"
    "Description"     = "${var.description}"
  }
}