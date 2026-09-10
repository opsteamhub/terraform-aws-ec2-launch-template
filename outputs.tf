output "lt_configs" {
  description = "Launch template resources keyed by launch_template_config key."
  value = { for k, v in aws_launch_template.lt :
    k => v
  }
}
