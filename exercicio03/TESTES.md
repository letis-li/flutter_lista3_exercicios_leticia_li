# Exercício 03 — Regras adicionais para o produto

## 1. Alterações realizadas

Foi adicionada uma condição ao `validator` do campo Nome, utilizando `trim().length` para exigir pelo menos três caracteres após a remoção dos espaços no início e no final do texto.

Também foi acrescentado um `validator` ao campo Descrição, que continua opcional, mas passa a aceitar no máximo 120 caracteres. 

A validação original do Preço foi mantida. Como o cadastro e a edição utilizam a mesma `TelaFormulario`, as novas regras são aplicadas nas duas operações.

## 2. Testes

Teste 1 (Nome curto — "Mo", preço 10): O nome deve ter pelo menos três caracteres.

Teste 2 (Nome "Mouse", preço 10 e descrição vazia): "Produto cadastrado com sucesso. A descrição é opcional."

Teste 3 (Descrição com 120 caracteres ou menos): "Produto cadastrado com sucesso."

Teste 4 (Descrição com 121 caracteres): "A descrição deve ter menos que 120 caracteres" e cadastro impedido.

## 3. Qual é a vantagem de ter uma única tela de formulário para as duas operações?

A vantagem é reutilizar os mesmos campos e as mesmas validações para cadastrar e editar produtos, evitando código repetido. Assim, qualquer alteração nas regras do formulário vale para as duas operações. Além disso, essa estrtutura facilita a manutenção do aplicativo.