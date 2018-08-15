
resource "aws_sqs_queue" "sqs_queue" {
  name                          = "${var.sqs_name}"
  message_retention_seconds     = "${var.message_retention_seconds}"
  receive_wait_time_seconds     = "${var.receive_wait_time_seconds}"
  visibility_timeout_seconds    = "${var.visibility_timeout_seconds}"
  # redrive_policy                = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.sqs_error_queue.arn}\",\"maxReceiveCount\":${var.redrive_policy_retry_count}}"  
  tags = {
    "Business Unit"             = "${var.tags_business_unit}"
    Environment                 = "${var.environment}"
    "Cost Center"               = "${var.tags_cost_center}"
    Team                        = "${var.tags_team}"
    Purpose                     = "${var.tags_purpose}"
    Description                 = "${var.description}"
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
      "Sid": "AllowReplayTopic",
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

#ERROR QUEUE

resource "aws_sqs_queue" "lambda_error_queue" {
  name                        = "${var.sqs_sns_name}-ERROR"
  message_retention_seconds   = 1209600
  tags                        = "${local.tags}"
}


resource "aws_sqs_queue_policy" "lambda_error_queue_policy" {
  queue_url = "${aws_sqs_queue.lambda_error_queue.id}"

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
      "Resource": "${aws_sqs_queue.lambda_error_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.error_sns.arn}"
        }
      }
    }
  ]
}
POLICY
}





