aws iam create-role \
  --role-name zayn-ecs-task-exec-role \
  --assume-role-policy-document '{
      "Version": "2012-10-17",
      "Statement": [
          {
              "Effect": "Allow",
              "Principal": {
                  "Service": "ecs-tasks.amazonaws.com"
              },
              "Action": "sts:AssumeRole"
          }
      ]
  }'
