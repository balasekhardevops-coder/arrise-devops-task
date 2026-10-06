variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "assume_role_arn" {
  description = "IAM role ARN Terraform will assume"
  type        = string
}

variable "instances" {
  description = "Configuration for all EC2 instances"

  type = map(object({
    instance_type = string
    key_name      = string
    volume_type   = string
    volume_size   = number
    iops          = optional(number)
    environment   = string
    owner         = string
  }))
}