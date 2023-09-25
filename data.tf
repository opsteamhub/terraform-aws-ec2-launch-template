#
# Retrieve AWS Session data
#
#data "aws_caller_identity" "session" {}

#
# Retrieve the AMI ID that should be used
#
data "aws_ami" "ami" {

  #
  # Use the datasource when the variable iamge_id is undefined.
  #
  for_each = {
    for k, v in var.launch_template_config :
    k => tolist([v["ami"]]) if try(v["ami"]["ami_filters"], null) != null
  }

  executable_users   = each.value[0]["executable_users"]
  include_deprecated = each.value[0]["include_deprecated"]
  most_recent        = each.value[0]["most_recent"]
  name_regex         = each.value[0]["name_regex"]
  owners             = each.value[0]["owners"]

  dynamic "filter" {
    for_each = each.value[0]["image_id"] == null ? toset(
      concat(
        coalesce(
          each.value[0]["ami_filters"],
          toset([])
        ),
        [
          {
            name   = "root-device-type"
            values = ["ebs"]
          },
          {
            name   = "virtualization-type"
            values = ["hvm"]
          }
        ]
      )
    ) : toset([])
    content {
      name   = filter.value["name"]
      values = filter.value["values"]
    }
  }
}

##
## Retrieve VPC to eventually attach it to the template.
## The return should always retrieve just one VPC.
##
#data "aws_vpc" "vpc" {
#
#  for_each = {
#      for k,v in var.launch_template_config:
#        k => v if v["vpc"] != null
#  }
#
#  #
#  # Generate filter maps
#  #
#  dynamic "filter" {
#    for_each = try(local.vpc_filters["custom_filters"], {})
#    content {
#      name   = filter.key
#      values = toset([filter.value])
#    }
#  }
#
#  #tags = local.vpc_filters["tags"]
#
#}