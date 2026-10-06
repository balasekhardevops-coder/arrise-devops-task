aws_region = "us-east-1"

assume_role_arn = "arn:aws:iam::75885456767589827:role/roleToAssumeRole"

instances = {
  web = {
    instance_type = "t3.micro"
    key_name      = "web-key"
    volume_type   = "gp3"
    volume_size   = 20
    environment   = "dev"
    owner         = "platform"
  }

  app = {
    instance_type = "t3.small"
    key_name      = "app-key"
    volume_type   = "gp2"
    volume_size   = 30
    environment   = "dev"
    owner         = "application"
  }

  api = {
    instance_type = "t3.medium"
    key_name      = "api-key"
    volume_type   = "io2"
    volume_size   = 40
    iops          = 3000
    environment   = "test"
    owner         = "backend"
  }

  batch = {
    instance_type = "m5.large"
    key_name      = "batch-key"
    volume_type   = "standard"
    volume_size   = 50
    environment   = "stage"
    owner         = "data"
  }

  prod = {
    instance_type = "m5.xlarge"
    key_name      = "prod-key"
    volume_type   = "io1"
    volume_size   = 100
    iops          = 5000
    environment   = "prod"
    owner         = "platform"
  }
}
