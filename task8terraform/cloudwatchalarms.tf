resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "z-strapi-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  dimensions = { ClusterName = "z-strapi-cluster", ServiceName = "z-strapi-service" }
}

resource "aws_cloudwatch_metric_alarm" "high_memory" {
  alarm_name          = "z-strapi-high-memory"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  dimensions = { ClusterName = "z-strapi-cluster", ServiceName = "z-strapi-service" }
}

resource "aws_cloudwatch_metric_alarm" "low_task_count" {
  alarm_name          = "z-strapi-low-tasks"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "RunningTaskCount"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Minimum"
  threshold           = 1
  dimensions = { ClusterName = "z-strapi-cluster", ServiceName = "z-strapi-service" }
}
