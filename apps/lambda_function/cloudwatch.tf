module "lambda_app_cloudwatch" {
  //source = "git@github.com:albumprinter/eops_tf_modules.git//apps/cloudwatch_lambda"
  source = "../../apps/cloudwatch_lambda"
  app_name = "${var.app_name}"
  log_group_name = "/aws/lambda/${var.app_name}"
  alarm_threshold = "${var.lambda_memory_alert_threshold}"
  alarm_action_arn = "${var.alarm_action_arn}"
  environment = "${var.environment}"
  tags_team = "${var.tags_team}"
  tags_domain = "${var.tags_domain}"
  description = "${var.description}"
  retention_days = "${var.retention_days}"
  tags_purpose = "${var.tags_purpose}"
  providers = {
   aws = "aws"
  }
}


