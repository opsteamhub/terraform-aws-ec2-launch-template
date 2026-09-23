# Terraform AWS EC2 Launch Template

Módulo Terraform para criar múltiplos EC2 Launch Templates com defaults seguros, seleção opcional de AMI e suporte aos principais blocos do recurso `aws_launch_template`.

## Compatibilidade

- Terraform `>= 1.9, < 2.0`
- AWS provider `>= 6.0, < 7.0`

Esta branch prepara a v2. Leia [docs/MIGRATION-v2.md](docs/MIGRATION-v2.md) antes de atualizar um consumidor existente.

## Uso rápido

```hcl
module "launch_templates" {
  source = "git::https://github.com/opsteamhub/terraform-aws-ec2-launch-template.git?ref=<release>"

  default_tags = {
    Environment = "production"
    Project     = "platform"
    Owner       = "sre"
  }

  launch_template_config = {
    workers = {
      name_prefix  = "eks-workers-"
      instance_type = "m7i.large"

      ami = {
        owners = ["amazon"]
        ami_filters = [{
          name   = "name"
          values = ["amazon-eks-node-al2023-x86_64-standard-1.35-*"]
        }]
      }

      metadata_options = {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 2
        instance_metadata_tags      = "enabled"
      }

      block_device_mappings = [{
        device_name = "/dev/xvda"
        ebs = {
          encrypted   = true
          volume_type = "gp3"
          volume_size = 80
        }
      }]
    }
  }
}
```

Não use `master` como referência de produção. Após a release, fixe uma tag SemVer ou SHA imutável.

## Comportamento importante

- `name` e `name_prefix` são mutuamente exclusivos.
- `Environment`, `Project` e `Owner` são obrigatórias no conjunto final de tags.
- IMDSv2 é exigido pelo default de `metadata_options.http_tokens`.
- AMI pode ser definida por `image_id` ou por filtros; filtros devem ser suficientemente específicos para evitar troca inesperada de imagem.
- `elastic_gpu_specifications` e `elastic_inference_accelerator` permanecem no tipo apenas para produzir um erro de migração claro; o AWS provider 6.x removeu esses blocos.

## Outputs

- `lt_configs`: recursos `aws_launch_template` indexados pela chave de entrada.

## Desenvolvimento

Consulte [CONTRIBUTING.md](CONTRIBUTING.md), [AGENTS.md](AGENTS.md) e [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md). Os testes usam provider mockado e não exigem credenciais AWS.
