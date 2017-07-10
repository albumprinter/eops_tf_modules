resource "aws_cloudwatch_event_rule" "app" {
  name                = "${var.app_name}"
  event_pattern = "${var.event_pattern}"
  count               = "${var.enabled}"
}

resource "aws_cloudwatch_event_target" "lambda" {
  target_id = "${var.app_name}"
  rule      = "${aws_cloudwatch_event_rule.app.name}"
  arn       = "${aws_lambda_function.app.arn}"
  count     = "${var.enabled}"
}
