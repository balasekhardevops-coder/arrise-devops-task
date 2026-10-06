With local state, two engineers can run `terraform apply` using separate state files, which can cause stale state and conflicting infrastructure changes.

The S3 backend provides one shared remote state for the team.

DynamoDB state locking ensures only one Terraform operation can modify the shared state at a time, preventing concurrent state updates.
