# Changelog

## [2.0.0](https://github.com/opsteamhub/terraform-aws-ec2-launch-template/compare/v1.0.0...v2.0.0) (2026-09-10)


### ⚠ BREAKING CHANGES

* Terraform 1.7, AWS provider 6, mandatory governance tags, and removal of Elastic GPU and Elastic Inference inputs are now required.

### Features

* modernize launch template module for AWS provider 6 ([fd391be](https://github.com/opsteamhub/terraform-aws-ec2-launch-template/commit/fd391be265caba09c02c5e53952bf7dc87ef2946))

## [Unreleased]

### Added

- Compatibilidade declarada com Terraform 1.7+ e AWS provider 6.x.
- Validações de nomes, tags obrigatórias e recursos removidos pelo provider.
- Exemplos, testes mockados, CI, documentação operacional e instruções para agentes.

### Fixed

- Uso incorreto de `network_interface_count` no bloco `network_bandwidth_gbps`.
- Iteração inválida de `capacity_reservation_target`.
- Inputs `name` e `name_prefix`, anteriormente ignorados.

### Removed

- Renderização dos blocos removidos `elastic_gpu_specifications` e `elastic_inference_accelerator`.
- Testes legados que dependiam de backend remoto e IDs específicos de uma conta.
