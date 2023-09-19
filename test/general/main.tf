module "lt" {
  source = "../.."
  launch_template_config = {
    a123 = {}
    b123 = {
      ami = {
        ami_filters = [
          {
            name   = "name"
            values = ["vtault"]
          }
        ]
      }
    }
    c123 = {
      ami = {
        owners = ["aws-marketplace"]
        ami_filters = [
          {
            name   = "name"
            values = ["CentOS-7-2111-20220825_1.x86_64-d9a3032a-921c-4c6d-b150-bde168105e42"]
          }
        ]
      }
    }
  }
}