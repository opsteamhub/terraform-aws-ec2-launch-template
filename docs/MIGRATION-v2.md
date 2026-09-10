# Migração para v2

1. Fixe o consumidor na última revisão conhecida antes de avaliar a v2; historicamente o repositório não possuía tags.
2. Atualize Terraform para 1.7+ e AWS provider para 6.x.
3. Remova `elastic_gpu_specifications` e `elastic_inference_accelerator`; os serviços e blocos correspondentes foram removidos do provider.
4. Adicione `Environment`, `Project` e `Owner` em `default_tags` ou em cada `tags`.
5. Se usava a chave do mapa como nome, o comportamento permanece `lt-<chave>`. Para corrigir o issue de prefixo, configure explicitamente apenas `name_prefix` e revise a substituição planejada.
6. Execute `terraform plan` em sandbox. Revise replacement, AMI, versão default, volumes, rede e IMDS antes de promover.

Rollback: restaure a referência imutável anterior do módulo e aplique somente após revisar se a v2 já criou uma nova versão ou substituiu o launch template.
