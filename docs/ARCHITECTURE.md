# Arquitetura

O módulo recebe um mapa em `launch_template_config` e cria um `aws_launch_template.lt` por chave. A chave continua sendo o endereço estável do recurso; renomeá-la altera o endereço Terraform.

A seleção de AMI é opcional. Quando `ami.image_id` não é fornecido e existem filtros, `data.aws_ami.ami` resolve a imagem. O chamador deve restringir owner, arquitetura e família para reduzir drift. Tags globais são mescladas às tags do template e a todas as `tag_specifications` configuradas.

O módulo não cria instâncias, Auto Scaling Groups, node groups, IAM, KMS, VPC ou Security Groups. Esses componentes recebem o ID/versão do output `lt_configs` e permanecem sob responsabilidade do root module.
