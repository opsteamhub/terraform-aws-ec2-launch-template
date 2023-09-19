output "lt_configs" {
  value = { for k,v in aws_launch_template.lt:
    k => v
  }
}