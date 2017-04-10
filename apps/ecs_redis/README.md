# Description
An example terraform module to build simple application as aws lambda function triggered by cloudwatch event scheduleder.

## Code Example

```hcl-terraform
resource "aws_sns_topic" "redis" {
  name = "MyRedisTopic"
}
module "cache" {
  source = "../eops_tf_modules/apps/ecs_redis"
  tags_team                  = "xsell"
  cache_identifier           = "cache"
  automatic_failover_enabled = "false"
  desired_clusters           = "1"
  instance_type              = "cache.t2.micro"
  engine_version             = "3.2.4"
  parameter_group            = "redis3.2"
  maintenance_window         = "sun:02:30-sun:03:30"
  notification_topic_arn     = "${aws_sns_topic.redis.arn}"

  alarm_cpu_threshold    = "75"
  alarm_memory_threshold = "10000000"
  alarm_actions          = ["${aws_sns_topic.redis.arn}"]

  project     = "Unknown"
  environment = "Unknown"
}
```