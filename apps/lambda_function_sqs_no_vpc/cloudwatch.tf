module "lambda_app_cloudwatch" {
  source = "git@github.com:albumprinter/eops_tf_modules.git//apps/cloudwatch_lambda?ref=v0.13.0"
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