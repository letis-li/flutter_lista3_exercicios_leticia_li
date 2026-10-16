# Exercício 07 — Impedir nomes repetidos

## 1. Alterações realizadas

Foi adicionada uma validação para impedir o cadastro e a edição de produtos com nomes repetidos, utilizando `trim()` e `toLowerCase()` para desconsiderar espaços nas extremidades e diferenças entre letras maiúsculas e minúsculas.

Também foi criada uma lista com os nomes dos outros produtos, enviada para `TelaFormulario`, permitindo verificar duplicações sem impedir que um produto seja editado mantendo seu próprio nome.

Quando um nome repetido é informado, o formulário apresenta uma mensagem de erro e mantém os dados digitados para correção.

## 2. Testes

Teste 1 (Cadastrar Mouse e Teclado): Ambos os produtos devem ser cadastrados normalmente.

Teste 2 (Tentar cadastrar mouse após cadastrar Mouse): Deve apresentar a mensagem "Já existe um produto com esse nome." e impedir o cadastro.

Teste 3 (Editar Mouse sem alterar seu nome): A edição deve ser permitida, mantendo a mesma quantidade de registros.

Teste 4 (Tentar renomear Teclado para Mouse): Deve apresentar a mensagem de nome repetido e impedir a edição.

Teste 5 (Cadastrar um produto com espaços nas extremidades e nome já existente): Deve impedir a duplicação, desconsiderando os espaços.