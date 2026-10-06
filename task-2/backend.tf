terraform {
  backend "s3" {
    bucket         = "arrise-assignment-terraform-state"
    key            = "task1/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "arrise-assignment-terraform-locks"
    encrypt        = true
  }
}
