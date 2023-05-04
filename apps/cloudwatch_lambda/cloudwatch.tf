resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name = "/aws/lambda/${var.app_name}"
  retention_in_days = "${var.retention_days}"
  tags = "${local.tags}"
}

resource "aws_cloudwatch_log_metric_filter" "lambda_memory_metric" {
  name = "${var.app_name}_memory_metric_filter"
  depends_on = ["aws_cloudwatch_log_group.lambda_log_group"]
  pattern = "${var.pattern}"
  log_group_name = "${var.log_group_name}"
  metric_transformation {
    name = "${var.app_name}-memory"
    namespace = "Albelli"
    value = "$MemUsed"
  }
}

resource "aws_cloudwatch_metric_alarm" "lambda_memory_alert" {
  alarm_name                = "${var.app_name}_memory_alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  datapoints_to_alarm       = "1"
  metric_name               = "${var.app_name}-memory"
  namespace                 = "Albelli"
  period                    = "${var.period}"
  statistic                 = "Maximum"
  threshold                 = "${var.alarm_threshold}"
  alarm_description         = "This metric alerts on memory usage"
  insufficient_data_actions = []
  alarm_actions = ["${var.alarm_action_arn}"]
  actions_enabled = "${var.alarm_action_enabled}"
  tags = "${local.tags}"
  count = "${var.enable_cloudwatch_alarms}"
  treat_missing_data  = "missing"
}

resource "aws_cloudwatch_metric_alarm" "lambda_duration_alert" {
  alarm_name          = "${var.app_name}_duration_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  datapoints_to_alarm = "1"
  metric_name         = "Duration"
  namespace           = "AWS/Lambda"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "${var.alarm_timeout * 1000 * 0.80}"
  alarm_description   = "${var.app_name} execution duration is approaching timeout"
  treat_missing_data  = "missing"
  insufficient_data_actions = []
  alarm_actions = ["${var.alarm_action_arn}"]
  ok_actions = []
  tags = "${local.tags}"
  count = "${var.enable_cloudwatch_alarms}"
  dimensions = {
    FunctionName = "${var.app_name}"
    Resource     = "${var.app_name}"
  }
}

resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  alarm_name          = "${var.app_name}_error_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  datapoints_to_alarm = "1"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "${var.app_name} error"
  treat_missing_data  = "notBreaching"
  insufficient_data_actions = []
  alarm_actions = ["${var.alarm_action_arn}"]
  ok_actions = []
  tags = "${local.tags}"
  count = "${local.enable_error_alarm}"
  dimensions = {
    FunctionName = "${var.app_name}"
    Resource     = "${var.app_name}"
  }
}