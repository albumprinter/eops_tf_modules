output "event_rule_arn" {
  value = var.enabled == true ? aws_cloudwatch_event_rule.rule[0].arn : ""
}

output "event_rule_name" {
  value = var.enabled == true ? aws_cloudwatch_event_rule.rule[0].name : ""
}