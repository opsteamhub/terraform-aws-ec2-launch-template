# Repository instructions

This repository contains a reusable Terraform module for AWS EC2 Launch Templates. Treat `variables.tf` as the input contract, `outputs.tf` as the output contract, and `docs/` as the design and migration record.

## Working rules

- Keep the module provider- and backend-agnostic. Credentials, region, state, and locking belong to the root module.
- Never run `terraform apply` or `terraform destroy` against a real AWS account while developing this module.
- Do not commit state, plans, provider binaries, credentials, customer identifiers, AMI IDs from private accounts, or backend configuration.
- Preserve resource addresses unless an intentional breaking change is documented in `docs/MIGRATION-v2.md`.
- Require `Environment`, `Project`, and `Owner` on every AWS resource.
- Keep IMDSv2 required by default and storage encryption enabled by default.
- Add positive and negative tests when changing an input contract.
- Use Conventional Commits in English. Do not create a tag or release from a feature branch.

## Required checks

```bash
terraform fmt -check -recursive
terraform init -backend=false -input=false
terraform validate
terraform test -test-directory=testing
terraform -chdir=examples/basic init -backend=false -input=false
terraform -chdir=examples/basic validate
tflint --init
tflint --recursive --format compact
trivy config --severity HIGH,CRITICAL --exit-code 1 .
```

Validate `.kiro/agents/local-agent.json` against its pinned schema before proposing changes.

## Review focus

Review plans for launch template replacement, default-version changes, AMI selection drift, public IP assignment, IMDS settings, unencrypted volumes, permissive security groups, Spot behavior, and changes propagated to Auto Scaling Groups or EKS managed node groups.
