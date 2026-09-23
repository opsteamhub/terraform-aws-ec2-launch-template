# Contribuindo

Use Terraform 1.9 ou superior. O módulo não precisa de credenciais AWS para validação e testes mockados.

```bash
terraform init -backend=false -input=false
terraform validate
terraform test -test-directory=testing
```

Mantenha o módulo sem `provider` e sem backend. Atualize README, migração, exemplos e testes ao alterar o contrato. Mudanças que substituam launch templates ou alterem a versão default devem incluir um plan de sandbox no PR. Use Conventional Commits em inglês e não publique release antes do merge aprovado.
