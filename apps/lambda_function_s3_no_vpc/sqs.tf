
#ERROR QUEUE
resource "aws_sqs_queue" "sqs_error_queue" {
  name                        = "${var.sqs_name}-ERROR"
  message_retention_seconds   = 1209600
  tags                        = "${local.tags}"
}

resource "aws_sqs_queue_policy" "sqs_error_queue_policy" {
  queue_url = "${aws_sqs_queue.sqs_error_queue.id}"

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
      "Resource": "${aws_sqs_queue.sqs_error_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sqs_queue.sqs_queue.arn}"
        }
      }
    }
  ]
}
POLICY
}