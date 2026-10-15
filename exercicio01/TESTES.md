# Exercício 01 — Nome válido e mensagem personalizada

## 1. Alterações realizadas

Foi adicionada uma segunda condição ao `validator` do campo Nome, utilizando `trim().length` para verificar se o texto possui pelo menos três caracteres, desconsiderando os espaços no início e no final.

A validação original de campos vazios ou preenchidos somente com espaços foi mantida. A saudação continua sendo exibida apenas quando o formulário é validado.

## 2. Testes

Teste 1 (Campo Vazio): Informe o nome.
Teste 2 (Um ou mais espaços somente): Informe o nome.
Teste 3 (Somente 2 caracteres "An"): O nome deve ter pelo menos três caracteres.
Teste 4 (Com 3 caracteres "Ana"): Olá, Ana!

## 3. Por que precisamos usar `trim()` antes de verificar o comprimento?

Porque `trim()` remove os espaços em branco do início e do final do texto, impedindo que eles sejam contabilizados como caracteres válidos do nome. Assim, a validação considera o comprimento real do nome informado.
