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

resource "aws_cloudwatch_metric_alarm" "stale_messages_alarm" {
  alarm_name                = "${var.app_name}-STALE-MESSAGES-ALARM"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "ApproximateAgeOfOldestMessage"
  namespace                 = "AWS/SQS"
  period                    = "3600"  // 1 hour
  statistic                 = "Maximum"
  threshold                 = "3600" // 1 hour
  datapoints_to_alarm       = "1"
  alarm_actions             = ["${var.alarm_action_arn}"]
  count                     = "${var.enable_cloudwatch_alarms}"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs_queue.name}"
  }
}


resource "aws_cloudwatch_metric_alarm" "error_messages_alarm" {
  alarm_name                = "${var.app_name}-ERROR-MESSAGES-ALARM"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "ApproximateAgeOfOldestMessage"
  namespace                 = "AWS/SQS"
  period                    = "60"  // 1 minute
  statistic                 = "Minimum"
  threshold                 = "60" // 1 minute
  datapoints_to_alarm       = "1"
  alarm_actions             = ["${var.alarm_action_arn}"]
  count                     = "${var.enable_cloudwatch_alarms}"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs_error_queue.name}"
  }
}