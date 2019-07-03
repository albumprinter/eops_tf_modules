output "queue_arn" {
  value = var.provision == true ? aws_sqs_queue.queue[0].arn : ""
}