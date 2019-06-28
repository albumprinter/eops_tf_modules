output "queue_arn" {
  value = var.enabled == true ? aws_sqs_queue.queue[0].arn : ""
}