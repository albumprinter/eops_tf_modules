resource "aws_sqs_queue" "sqs_queue" {
  name                      = "${var.app_name}"
  message_retention_seconds = "${var.message_retention_seconds}"
  receive_wait_time_seconds = "${var.receive_wait_time_seconds}"
  redrive_policy            = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.sqs_error_queue.arn}\",\"maxReceiveCount\":${var.redrive_policy_retry_count}}"  
  tags = {
    "Business Unit" = "${var.tags_business_unit}"
    Environment = "${var.environment}"
    "Cost Center" = "${var.tags_cost_center}"
    Team = "${var.tags_team}"
    Purpose = "${var.tags_purpose}"
    Description = "${var.description}"
  }
}

resource "aws_sqs_queue_policy" "sqs_sns_policy" {
  queue_url = "${aws_sqs_queue.sqs_queue.id}"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.sqs_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${var.sns_subscription_arn}"
        }
      }
    },
     {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.sqs_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.replay_sns.arn}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_sqs_queue" "sqs_error_queue" {
  name                      = "${var.app_name}-ERROR"
  message_retention_seconds = 1209600
}