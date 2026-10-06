Task 4 — Least-Privilege Policy Writing
Write a custom IAM policy (not a managed policy like PowerUserAccess) for the ci user from Task 3, scoped to only what a CI pipeline actually needs to do the following — nothing more:
•	Push a Docker image to a specific ECR repository.
•	Deploy a new task definition to a specific ECS service.
•	Read (not write) a specific S3 bucket used for build artifacts.
Write the policy JSON and explain in NOTES.md what you deliberately left out and why.



# IAM Policy

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ECRAuthentication",
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken"
      ],
      "Resource": "*"
    },
    {
      "Sid": "PushImageToSpecificECRRepository",
      "Effect": "Allow",
      "Action": [
        "ecr:BatchCheckLayerAvailability",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload",
        "ecr:PutImage"
      ],
      "Resource": "arn:aws:ecr:us-east-1:000000000000:repository/my-app"
    },
    {
      "Sid": "RegisterTaskDefinition",
      "Effect": "Allow",
      "Action": [
        "ecs:RegisterTaskDefinition"
      ],
      "Resource": "*"
    },
    {
      "Sid": "DeploySpecificECSService",
      "Effect": "Allow",
      "Action": [
        "ecs:UpdateService"
      ],
      "Resource": "arn:aws:ecs:us-east-1:000000000000:service/my-cluster/my-service"
    },
    {
      "Sid": "PassECSTaskRoles",
      "Effect": "Allow",
      "Action": [
        "iam:PassRole"
      ],
      "Resource": [
        "arn:aws:iam::000000000000:role/ecsTaskExecutionRole",
        "arn:aws:iam::000000000000:role/myAppTaskRole"
      ],
      "Condition": {
        "StringEquals": {
          "iam:PassedToService": "ecs-tasks.amazonaws.com"
        }
      }
    },
    {
      "Sid": "ListBuildArtifactsBucket",
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket"
      ],
      "Resource": "arn:aws:s3:::my-build-artifacts"
    },
    {
      "Sid": "ReadBuildArtifacts",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": "arn:aws:s3:::my-build-artifacts/*"
    }
  ]
}
```


The CI user is granted only the permissions required to push images to one ECR repository, register ECS task definitions, update one specific ECS service, pass only the required ECS task/execution roles, and read artifacts from one specific S3 bucket.

I deliberately excluded ECR repository creation/deletion, ECS cluster or service creation/deletion, S3 write/delete permissions, and general IAM administration because the CI pipeline does not require them.

`ecr:GetAuthorizationToken` and `ecs:RegisterTaskDefinition` use `Resource: "*"` because these actions cannot be meaningfully restricted to the target repository/service ARN using IAM resource-level permissions.

`iam:PassRole` is restricted to the exact ECS task/execution roles and to the ECS tasks service. No `iam:*` permissions are granted.

S3 access is read-only: `ListBucket` is allowed on the bucket and `GetObject` on its objects. The CI user cannot upload, modify, or delete artifacts.
