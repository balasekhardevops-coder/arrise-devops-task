resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
    iops        = var.iops
  }

  tags = {
    Name        = var.instance_name
    Environment = var.environment
    Owner       = var.owner
  }

  lifecycle {
    prevent_destroy = true
  }
}