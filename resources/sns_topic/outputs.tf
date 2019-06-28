output "topic_arn" {
  value = var.enabled == true ? aws_sns_topic.topic[0].arn : ""
}
