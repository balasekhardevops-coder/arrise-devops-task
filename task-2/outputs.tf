output "instance_ids" {
  description = "Map of instance name to instance ID"

  value = merge(
    {
      for name, instance in module.ec2 :
      name => instance.instance_id
    },
    {
      for name, instance in module.protected_ec2 :
      name => instance.instance_id
    }
  )
}

output "private_ips" {
  description = "Map of instance name to private IP"

  value = merge(
    {
      for name, instance in module.ec2 :
      name => instance.private_ip
    },
    {
      for name, instance in module.protected_ec2 :
      name => instance.private_ip
    }
  )
}