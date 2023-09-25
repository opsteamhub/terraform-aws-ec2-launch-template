#
# Retrieving information of lates published amazon linux AMI
#
data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }
  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

#
# Retrieving information of security groups for launch template
#
# data "aws_security_groups" "sg" {
#   filter {
#     name   = "tag:Name"
#     values = ["WebDMZ"]
#   }
#   filter {
#     name   = "vpc-id"
#     values = [module.vpc_module.vpc_ids["vpc"]]
#   }
# }
