module "lt" {
  source = "../.."
  launch_template_config = {
    server1 = {

      name = "WebServe01"

      capacity_reservation_specification = {}

      cpu_options = null

      image_id = data.aws_ami.amazon_linux.id

      # ami_filters = [
      #   {
      #     name   = "name"
      #     values = ["vtault"]
      #   }
      # ]

      instance_type = "t2.micro"

      instance_requirements = null

      network_interfaces = {
        associate_public_ip_address = true
      }

      vpc_security_group_ids = ["sg-0096b29faa35d7ae6"]

      ebs_optimized = false

      user_data = base64encode(<<EOF
                #!/bin/bash
                yum update -y
                yum install httpd -y
                yum install git -y
                service httpd start 
                systemctl enable httpd 
                cd /var/www/html 
                rm -rf /var/www/html/{*,.*} * 
                git clone https://github.com/biagolini/WebPageBlackjack.git /var/www/html
                chown -R apache:apache /var/www/html 
                chmod -R 755 /var/www/html 
                EOF
      )

      update_default_version = true
    }
  }
}