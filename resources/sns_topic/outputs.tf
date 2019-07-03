output "topic_arn" {
  value = var.provision == true ? aws_sns_topic.topic[0].arn : ""
}
