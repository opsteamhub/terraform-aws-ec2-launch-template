# Política de segurança

Reporte vulnerabilidades pelo fluxo privado de [GitHub Security Advisories](https://github.com/opsteamhub/terraform-aws-ec2-launch-template/security/advisories/new) ou diretamente a um mantenedor da OpsTeamHub. Não publique credenciais, state Terraform, dados de clientes ou evidências executadas em produção.

O consumidor controla IAM, VPC, AMIs, user data, chaves KMS e associação do template a EC2, ASG ou EKS. Revise especialmente IMDSv2, criptografia EBS, IP público, grupos de segurança, origem da AMI e conteúdo de user data antes de aplicar.
