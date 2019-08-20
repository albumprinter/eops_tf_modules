variable "region" {
  default = "eu-west-1"
}
variable "account_type" {
  default = "sandbox"
}
variable "tags_business_unit" {
  default = "Albumprinter"
}
variable "redis_cidr" {
  description = "cidr range that has access to Redis. By default all the shared VPC ranges"
  default     = "10.96.0.0/12"
}
variable "tags_cost_center" {}
variable "tags_team" {}
variable "tags_domain" {}
variable "tags_purpose" {
  default = ""
}
variable "environment" {
  default = "Unknown"
}
variable "app_name" {
  default = "Unknown"
}
variable "description" {
  default = "Unknown"
}

variable "costcenter" {
  default = "Unknown"
}

variable "cache_identifier" {}

variable "parameter_group" {
  description = "For cluster mode override with: default.redis3.2.cluster.on"
  default     = "default.redis3.2"
}

variable "maintenance_window" {}

variable "number_cache_clusters" {
  default = "1"
}

variable "node_type" {
  default = "cache.t2.micro"
}

variable "engine_version" {
  default = "3.2.4"
}

variable "automatic_failover_enabled" {
  default = false
}

variable "notification_topic_arn" {}

variable "alarm_cpu_threshold" {
  default = "75"
}

variable "alarm_memory_threshold" {
  # 10MB
  default = "10000000"
}

variable "alarm_actions" {
  type = "list"
}
