Execution role for Fargate (pull image from ECR and send logs to CW)
resource "aws_iam_role" "zayn_task_execution_role" {
name = "${var.prefix}-ecs-task-exec-role"
assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
}


data "aws_iam_policy_document" "ecs_task_assume_role" {
statement {
effect = "Allow"
principals {
type = "Service"
identifiers = ["ecs-tasks.amazonaws.com"]
}
actions = ["sts:AssumeRole"]
}
}


resource "aws_iam_role_policy_attachment" "zayn_exec_policy" {
role = aws_iam_role.zayn_task_execution_role.name
policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


# Task role (optional - for app permissions)
resource "aws_iam_role" "zayn_task_role" {
name = "${var.prefix}-ecs-task-role"
assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
}