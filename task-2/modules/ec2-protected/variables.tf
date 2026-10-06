variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "volume_type" {
  description = "Root EBS volume type"
  type        = string
}

variable "volume_size" {
  description = "Root EBS volume size"
  type        = number
}

variable "iops" {
  description = "IOPS for io1/io2 volumes"
  type        = number
  default     = null
}

variable "environment" {
  description = "Environment tag"
  type        = string
}

variable "owner" {
  description = "Owner tag"
  type        = string
}