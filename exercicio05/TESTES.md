# Exercício 05 — Acrescentar a quantidade em estoque

## 1. Alterações realizadas

Foi adicionado o atributo `quantidade` do tipo `int` à classe `Produto`, junto com um novo `TextEditingController` e um `TextFormField` para receber a quantidade em estoque.

Foi criada a função `validarQuantidade()`, utilizando `int.tryParse()` para verificar se a quantidade informada é um número inteiro, impedindo campos vazios, valores negativos, decimais ou não numéricos.

Também foi atualizada a função `salvar()` para incluir a quantidade no objeto `Produto`, além de apresentar esse valor na lista e na tela de detalhes. O campo também é preenchido automaticamente ao editar um produto.

## 2. Testes

Teste 1 (Campo vazio): Informe a quantidade.

Teste 2 (Entrada não numérica "abc"): Digite uma quantidade inteira válida.

Teste 3 (Quantidade negativa "-1"): A quantidade não pode ser negativa.

Teste 4 (Quantidade decimal "2.5"): Digite uma quantidade inteira válida.

Teste 5 (Quantidade igual a zero): Cadastro permitido.

Teste 6 (Cadastro com quantidade 3 e edição para 5): Quantidade atualizada para 5, mantendo o mesmo produto cadastrado.