# Exercício 03 — Regras adicionais para o produto

## 1. Alterações realizadas

Foi adicionada uma condição ao `validator` do campo Nome, utilizando `trim().length` para exigir pelo menos três caracteres após a remoção dos espaços no início e no final do texto.

Também foi acrescentado um `validator` ao campo Descrição, que continua opcional, mas passa a aceitar no máximo 120 caracteres. A validação original do Preço foi mantida. Como o cadastro e a edição utilizam a mesma `TelaFormulario`, as novas regras são aplicadas nas duas operações.

## 2. Testes

Teste 1 (Nome curto — "Al", preço 10): resultado esperado — "O nome deve ter pelo menos três caracteres." Resultado observado: **a preencher**.

Teste 2 (Nome "Mouse", preço 10 e descrição vazia): resultado esperado — produto cadastrado com sucesso, pois a descrição é opcional. Resultado observado: **a preencher**.

Teste 3 (Descrição com exatamente 120 caracteres): resultado esperado — cadastro permitido. Resultado observado: **a preencher**.

Teste 4 (Descrição com 121 caracteres): resultado esperado — "A descrição deve ter no máximo 120 caracteres." e cadastro impedido. Resultado observado: **a preencher**.

Teste 5 (Editar um produto e inserir descrição com 121 caracteres): resultado esperado — a mesma mensagem de validação, sem salvar a edição. Resultado observado: **a preencher**.

## 3. Qual é a vantagem de ter uma única tela de formulário para as duas operações?

A vantagem é reutilizar os mesmos campos e as mesmas validações para cadastrar e editar produtos, evitando código repetido. Assim, qualquer alteração nas regras do formulário vale para as duas operações e facilita a manutenção do aplicativo.
