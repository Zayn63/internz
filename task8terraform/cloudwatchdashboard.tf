resource "aws_cloudwatch_dashboard" "ecs_dashboard" {
  dashboard_name = "z-strapi-dashboard"
  dashboard_body = jsonencode({
    widgets = [{
      type = "metric"
      x = 0
      y = 0
      width = 12
      height = 6
      properties = {
        metrics = [
          ["AWS/ECS","CPUUtilization","ClusterName","z-strapi-cluster","ServiceName","z-strapi-service"],
          ["AWS/ECS","MemoryUtilization","ClusterName","z-strapi-cluster","ServiceName","z-strapi-service"],
          ["AWS/ECS","NetworkIn","ClusterName","z-strapi-cluster","ServiceName","z-strapi-service"],
          ["AWS/ECS","NetworkOut","ClusterName","z-strapi-cluster","ServiceName","z-strapi-service"]
        ]
        period = 60
        stat   = "Average"
        region = "ap-south-1"
        title  = "Strapi ECS Metrics"
      }
    }]
  })
}
