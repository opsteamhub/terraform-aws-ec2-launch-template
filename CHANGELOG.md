# Changelog

## [Unreleased]

### Added

- Compatibilidade declarada com Terraform 1.9+ e AWS provider 6.x.
- Validações de nomes, tags obrigatórias e recursos removidos pelo provider.
- Exemplos, testes mockados, CI, documentação operacional e instruções para agentes.

### Fixed

- Uso incorreto de `network_interface_count` no bloco `network_bandwidth_gbps`.
- Iteração inválida de `capacity_reservation_target`.
- Inputs `name` e `name_prefix`, anteriormente ignorados.

### Removed

- Renderização dos blocos removidos `elastic_gpu_specifications` e `elastic_inference_accelerator`.
- Testes legados que dependiam de backend remoto e IDs específicos de uma conta.
