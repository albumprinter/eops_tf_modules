module "lambda_app_cloudwatch" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//apps/cloudwatch_lambda?ref=v0.14.7"
  app_name = "${var.app_name}"
  log_group_name = "/aws/lambda/${var.app_name}"
  alarm_threshold = "${var.lambda_memory_alert_threshold}"
  alarm_action_arn = "${var.alarm_action_arn}"
  environment = "${var.environment}"
  tags_team = "${var.tags_team}"
  tags_purpose = "${var.tags_purpose}"
  description = "${var.description}"
  retention_days = "${var.retention_days}"  
}

resource "aws_cloudwatch_metric_alarm" "stale_messages_alarm_1" {
  alarm_name                = "${var.app_name}-STALE-MESSAGES-ALARM-1"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "ApproximateAgeOfOldestMessage"
  namespace                 = "AWS/SQS"
  period                    = "900"  // 15 minutes
  statistic                 = "Maximum"
  threshold                 = "3600" // 1 hour
  datapoints_to_alarm       = "1"
  alarm_actions             = ["${var.alarm_action_arn}"]
  count                     = "${var.add_stale_message_cloudwatch}"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs_error_queue.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "stale_messages_alarm_2" {
  alarm_name                = "${var.app_name}-STALE-MESSAGES-ALARM-2"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "ApproximateAgeOfOldestMessage"
  namespace                 = "AWS/SQS"
  period                    = "10800" // 3 hours
  statistic                 = "Maximum"
  threshold                 = "86400" // 1 day
  datapoints_to_alarm       = "1"
  alarm_actions             = ["${var.alarm_action_arn}"]
  count                     = "${var.add_stale_message_cloudwatch}"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs_error_queue.name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "stale_messages_alarm_3" {
  alarm_name                = "${var.app_name}-STALE-MESSAGES-ALARM-3"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "ApproximateAgeOfOldestMessage"
  namespace                 = "AWS/SQS"
  period                    = "86400"  // 1 day
  statistic                 = "Maximum"
  threshold                 = "259200" // 3 days
  datapoints_to_alarm       = "1"
  alarm_actions             = ["${var.alarm_action_arn}"]
  count                     = "${var.add_stale_message_cloudwatch}"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs_error_queue.name}"
  }
}