module "lt" {
  source = "../.."
  launch_template_config = {
    template_01 = {

      name = "template_01"

      key_name = "myKey"

      capacity_reservation_specification = {}

      cpu_options = null

      vpc_security_group_ids = ["sg-0096b29faa35d7ae6"]

      network_interfaces = {
        associate_public_ip_address = true
        device_index                = 0
        subnet_id                   = "subnet-0953d69092138044a"
      }

      ami = {
        image_id = data.aws_ami.amazon_linux.id
      }

      instance_type = "t2.micro"

      instance_requirements = null


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

      update_default_version             = true
      disable_api_stop_compatible        = false
      disable_api_stop                   = false
      disable_api_termination_compatible = false
      disable_api_termination            = false
      ebs_optimized                      = false
    }
    template_02 = {
      # NOTE: without network_interfaces 

      name = "template_02"

      capacity_reservation_specification = {}

      cpu_options = null

      ami = {
        image_id = data.aws_ami.amazon_linux.id
      }

      instance_type = "t2.micro"

      instance_requirements = null


      vpc_security_group_ids = ["sg-0096b29faa35d7ae6"]

      ebs_optimized = false

      user_data = base64encode(<<EOF
                #!/bin/bash
                yum update -y # Update the package manager
                yum install httpd -y # Install Apache web server
                yum install git -y # Install git
                service httpd start # Start Apache web server
                systemctl enable httpd # Enable Apache to start automatically on boot
                cd /var/www/html # Change to the web server directory
                rm -rf /var/www/html/{*,.*} * # Remove any default content (including hidden files and directories)
                git clone https://github.com/biagolini/WebPageTicTacToe.git /var/www/html/b # Clone the Github repository
                chown -R apache:apache /var/www/html # Change the ownership of files and directories (-R to be recursive, i.e. subfolders includes) to the user apache and the group apache
                chmod -R 755 /var/www/html # it allows the server to access the files and serve them to users, while also preventing unauthorized users from modifying the files.
                EOF
      )

      update_default_version             = true
      disable_api_stop_compatible        = false
      disable_api_stop                   = false
      disable_api_termination_compatible = false
      disable_api_termination            = false
      ebs_optimized                      = false
    }
  }
}