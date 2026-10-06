module "ec2" {
  source = "./modules/ec2"

  for_each = {
    for name, config in var.instances :
    name => config
    if name != "prod"
  }

  ami_id        = data.aws_ami.amazon_linux.id
  instance_name = each.key

  instance_type = each.value.instance_type
  key_name      = each.value.key_name

  volume_type = each.value.volume_type
  volume_size = each.value.volume_size
  iops        = each.value.iops

  environment = each.value.environment
  owner       = each.value.owner
}


module "protected_ec2" {
  source = "./modules/ec2-protected"

  for_each = {
    for name, config in var.instances :
    name => config
    if name == "prod"
  }

  ami_id        = data.aws_ami.amazon_linux.id
  instance_name = each.key

  instance_type = each.value.instance_type
  key_name      = each.value.key_name

  volume_type = each.value.volume_type
  volume_size = each.value.volume_size
  iops        = each.value.iops

  environment = each.value.environment
  owner       = each.value.owner
}
