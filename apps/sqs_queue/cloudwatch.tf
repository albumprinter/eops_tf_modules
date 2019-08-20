resource "aws_cloudwatch_metric_alarm" "stale_messages_alarm_1" {
  alarm_name          = "${var.queue_name}-STALE-MESSAGES-ALARM-1"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApproximateAgeOfOldestMessage"
  namespace           = "AWS/SQS"
  period              = "900" // 15 minutes
  statistic           = "Maximum"
  threshold           = "3600" // 1 hour
  datapoints_to_alarm = "1"
  alarm_actions       = ["${var.sns_alert_arn}"]
  count               = "${var.add_stale_message_cloudwatch}"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs_queue.name}"
  }
  tags = "${local.tags}"
}

resource "aws_cloudwatch_metric_alarm" "stale_messages_alarm_2" {
  alarm_name          = "${var.queue_name}-STALE-MESSAGES-ALARM-2"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApproximateAgeOfOldestMessage"
  namespace           = "AWS/SQS"
  period              = "10800" // 3 hours
  statistic           = "Maximum"
  threshold           = "86400" // 1 day
  datapoints_to_alarm = "1"
  alarm_actions       = ["${var.sns_alert_arn}"]
  count               = "${var.add_stale_message_cloudwatch}"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs_queue.name}"
  }
  tags = "${local.tags}"
}

resource "aws_cloudwatch_metric_alarm" "stale_messages_alarm_3" {
  alarm_name          = "${var.queue_name}-STALE-MESSAGES-ALARM-3"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApproximateAgeOfOldestMessage"
  namespace           = "AWS/SQS"
  period              = "86400" // 1 day
  statistic           = "Maximum"
  threshold           = "259200" // 3 days
  datapoints_to_alarm = "1"
  alarm_actions       = ["${var.sns_alert_arn}"]
  count               = "${var.add_stale_message_cloudwatch}"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs_queue.name}"
  }
  tags = "${local.tags}"
}

resource "aws_cloudwatch_metric_alarm" "error_messages_alarm_1" {
  alarm_name          = "${var.queue_name}-ERROR-MESSAGES-ALARM-1"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApproximateAgeOfOldestMessage"
  namespace           = "AWS/SQS"
  period              = "60" // 1 minute
  statistic           = "Minimum"
  threshold           = "60" // 1 minute
  treat_missing_data  = "notBreaching"
  datapoints_to_alarm = "1"
  alarm_actions       = ["${var.sns_alert_arn}"]
  count               = "${var.add_error_messages_cloudwatch}"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs_error_queue.name}"
  }
  tags = "${local.tags}"
}

resource "aws_cloudwatch_metric_alarm" "error_messages_alarm_2" {
  alarm_name          = "${var.queue_name}-ERROR-MESSAGES-ALARM-2"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApproximateAgeOfOldestMessage"
  namespace           = "AWS/SQS"
  period              = "3600" // 1 hour
  statistic           = "Maximum"
  threshold           = "3600" // 1 hour
  treat_missing_data  = "notBreaching"
  datapoints_to_alarm = "1"
  alarm_actions       = ["${var.sns_alert_arn}"]
  count               = "${var.add_error_messages_cloudwatch}"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs_error_queue.name}"
  }
  tags = "${local.tags}"
}

resource "aws_cloudwatch_metric_alarm" "error_messages_alarm_3" {
  alarm_name          = "${var.queue_name}-ERROR-MESSAGES-ALARM-3"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = "900" // 15 minutes
  statistic           = "Maximum"
  threshold           = "10" // 1 hour
  treat_missing_data  = "notBreaching"
  datapoints_to_alarm = "1"
  alarm_actions       = ["${var.sns_alert_arn}"]
  count               = "${var.add_error_messages_cloudwatch}"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs_error_queue.name}"
  }
  tags = "${local.tags}"
}

