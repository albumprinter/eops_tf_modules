#
# Security group resources
#
resource "aws_security_group" "redis" {
  vpc_id      = "${module.aws_core_data.vpc_id}"
  description = "Allow all inbound traffic for the scheduled lambda function"

  tags = {
    Domain          = "${var.tags_domain}"
    Name            = "${var.app_name}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
  }
}

resource "aws_security_group_rule" "redis_ingress" {
  type              = "ingress"
  security_group_id = "${aws_security_group.redis.id}"
  description       = "Allow access to Redis"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  cidr_blocks       = ["${var.redis_cidr}"]
}
resource "aws_security_group_rule" "redis_egress" {
  security_group_id = "${aws_security_group.redis.id}"
  description       = "Allow all outgoing"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}



resource "aws_elasticache_subnet_group" "redis" {
  name       = "${var.app_name}"
  subnet_ids = flatten([module.aws_core_data.private_subnets])
}

#
# ElastiCache resources
#
resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "${lower(var.cache_identifier)}"
  replication_group_description = "${var.description}"
  automatic_failover_enabled    = "${var.automatic_failover_enabled}"
  number_cache_clusters         = "${var.number_cache_clusters}"
  node_type                     = "${var.node_type}"
  engine_version                = "${var.engine_version}"
  parameter_group_name          = "${var.parameter_group}"
  subnet_group_name             = "${aws_elasticache_subnet_group.redis.name}"
  security_group_ids            = ["${aws_security_group.redis.id}"]
  maintenance_window            = "${var.maintenance_window}"
  notification_topic_arn        = "${var.notification_topic_arn}"
  port                          = 6379

  tags = {
    Domain          = "${var.tags_domain}"
    Name            = "${var.app_name}"
    "Business Unit" = "${var.tags_business_unit}"
    "Cost Center"   = "${var.tags_cost_center}"
    Team            = "${var.tags_team}"
    Purpose         = "${var.tags_purpose}"
    Description     = "${var.description}"
    Environment     = "${var.environment}"
  }
}
//resource "aws_elasticache_replication_group" "foo-replication-group" {
//  replication_group_id          = "foo"
//  replication_group_description = "Foo replication group"
//  node_type                     = "cache.m1.small"
//  number_cache_clusters         = 2
//  port                          = 6379
//  parameter_group_name          = "default.redis3.2.cluster.on"
//  availability_zones            = ["eu-west-1a", "eu-west-1b"]
//  automatic_failover_enabled    = true
//  security_group_ids            = ["${aws_security_group.foo_sg.id}"]
//  subnet_group_name             = "${aws_elasticache_subnet_group.foo-subnets.name}"
//}

#
# CloudWatch resources
#
resource "aws_cloudwatch_metric_alarm" "cache_cpu" {
  count = "${var.number_cache_clusters}"

  alarm_name          = "alarm${var.environment}CacheCluster00${count.index + 1}CPUUtilization"
  alarm_description   = "Redis cluster CPU utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ElastiCache"
  period              = "300"
  statistic           = "Average"

  threshold = "${var.alarm_cpu_threshold}"

  dimensions = {
    CacheClusterId = "${aws_elasticache_replication_group.redis.id}-00${count.index + 1}"
  }

  alarm_actions = ["${var.alarm_actions}"]
}

resource "aws_cloudwatch_metric_alarm" "cache_memory" {
  count = "${var.number_cache_clusters}"

  alarm_name          = "alarm${var.environment}CacheCluster00${count.index + 1}FreeableMemory"
  alarm_description   = "Redis cluster freeable memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "FreeableMemory"
  namespace           = "AWS/ElastiCache"
  period              = "60"
  statistic           = "Average"

  threshold = "${var.alarm_memory_threshold}"

  dimensions = {
    CacheClusterId = "${aws_elasticache_replication_group.redis.id}-00${count.index + 1}"
  }

  alarm_actions = ["${var.alarm_actions}"]
}


