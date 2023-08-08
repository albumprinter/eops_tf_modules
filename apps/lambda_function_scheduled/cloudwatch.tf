resource "aws_cloudwatch_event_rule" "app" {
  name                = "${var.app_name}"
  schedule_expression = "${var.schedule_expression}"
  count               = "${var.enabled}"
  tags = "${local.tags}"
  is_enabled = "${var.cloudwatch_event_rule_is_enabled}"
}

resource "aws_cloudwatch_event_target" "lambda" {
  target_id = "${var.app_name}"
  rule      = "${aws_cloudwatch_event_rule.app[0].name}"
  arn       = "${aws_lambda_function.app[0].arn}"
  count     = "${var.enabled}"
}
