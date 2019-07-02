resource "aws_cloudwatch_event_rule" "app" {
  name                = "${var.app_name}"
  schedule_expression = "${var.schedule_expression}"
  count               = "${var.enabled}"
}

resource "aws_cloudwatch_event_target" "lambda_vpc" {
  target_id = "${var.app_name}"
  rule      = "${aws_cloudwatch_event_rule.app.name}"
  arn       = "${aws_lambda_function.app.arn}"
  count     = "${var.enabled}"
}

module "lambda_app_cloudwatch" {
  source = "../../apps/cloudwatch_lambda"
  app_name = "${var.app_name}"
  log_group_name = "/aws/lambda/${var.app_name}"
  alarm_threshold = "${var.lambda_memory_alert_threshold}"
  alarm_action_arn = "${var.alarm_action_arn}"
  environment = "${var.environment}"
  tags_team = "${var.tags_team}"
  tags_domain = "${var.tags_domain}"
  description = "${var.description}"
  tags_purpose = "${var.tags_purpose}"
  retention_days = "${var.retention_days}"  

  providers = {
   aws = "aws"
  }
}