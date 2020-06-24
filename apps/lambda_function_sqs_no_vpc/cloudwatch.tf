module "lambda_app_cloudwatch" {
  source                   = "../../apps/cloudwatch_lambda"
  app_name                 = "${var.app_name}"
  log_group_name           = "/aws/lambda/${var.app_name}"
  alarm_threshold          = "${var.lambda_memory_alert_threshold}"
  alarm_timeout            = "${var.timeout}"
  alarm_action_arn         = "${var.alarm_action_arn}"
  environment              = "${var.environment}"
  tags_team                = "${var.tags_team}"
  tags_domain              = "${var.tags_domain}"
  tags_purpose             = "${var.tags_purpose}"
  tags_cost_center         = "${var.tags_cost_center}"
  description              = "${var.description}"
  retention_days           = "${var.retention_days}"
  enable_cloudwatch_alarms = "${var.enable_cloudwatch_alarms}"
  enable_cloudwatch_error_alarm = 0
  providers = {
    aws = "aws"
  }
}

resource "aws_cloudwatch_metric_alarm" "stale_messages_alarm" {
  alarm_name          = "${var.app_name}-STALE-MESSAGES-ALARM"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApproximateAgeOfOldestMessage"
  namespace           = "AWS/SQS"
  period              = "3600" // 1 hour
  statistic           = "Maximum"
  threshold           = "3600" // 1 hour
  datapoints_to_alarm = "1"
  alarm_actions       = ["${var.alarm_action_arn}"]
  count               = "${var.enable_cloudwatch_alarms}"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs_queue.name}"
  }
  tags = "${local.tags}"
}


resource "aws_cloudwatch_metric_alarm" "error_messages_alarm_1" {
  alarm_name          = "${var.app_name}-ERROR-MESSAGES-ALARM-1"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApproximateAgeOfOldestMessage"
  namespace           = "AWS/SQS"
  period              = "60" // 1 minute
  statistic           = "Minimum"
  threshold           = "60" // 1 minute
  treat_missing_data  = "notBreaching"
  datapoints_to_alarm = "1"
  alarm_actions       = ["${var.alarm_action_arn}"]
  count               = "${var.enable_cloudwatch_alarms}"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs_error_queue.name}"
  }
  tags = "${local.tags}"
}

resource "aws_cloudwatch_metric_alarm" "error_messages_alarm_2" {
  alarm_name          = "${var.app_name}-ERROR-MESSAGES-ALARM-2"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApproximateAgeOfOldestMessage"
  namespace           = "AWS/SQS"
  period              = "3600" // 1 hour
  statistic           = "Maximum"
  threshold           = "3600" // 1 hour
  treat_missing_data  = "notBreaching"
  datapoints_to_alarm = "1"
  alarm_actions       = ["${var.alarm_action_arn}"]
  count               = "${var.enable_cloudwatch_alarms}"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs_error_queue.name}"
  }
  tags = "${local.tags}"
}

resource "aws_cloudwatch_metric_alarm" "error_messages_alarm_3" {
  alarm_name          = "${var.app_name}-ERROR-MESSAGES-ALARM-3"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApproximateNumberOfMessagesVisible"
  namespace           = "AWS/SQS"
  period              = "900" // 15 minutes
  statistic           = "Maximum"
  threshold           = "10" // 1 hour
  treat_missing_data  = "notBreaching"
  datapoints_to_alarm = "1"
  alarm_actions       = ["${var.alarm_action_arn}"]
  count               = "${var.enable_cloudwatch_alarms}"
  dimensions {
    QueueName = "${aws_sqs_queue.sqs_error_queue.name}"
  }
  tags = "${local.tags}"
}
