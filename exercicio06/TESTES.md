# Exercício 06 — Calcular o valor total do estoque

## 1. Alterações realizadas

Foi criada a função `calcularTotalEstoque()`, utilizando uma repetição `for` para percorrer a lista de produtos e somar o valor de cada item, multiplicando seu preço pela quantidade.

Também foi adicionado o valor total individual de cada produto nos Cards e o valor total geral do estoque na tela principal, utilizando `toStringAsFixed(2)` para apresentar os resultados com duas casas decimais.

O total é recalculado após cadastrar, editar ou excluir produtos por meio do `setState()` já presente nessas operações.

## 2. Testes

Teste 1 (Cadastrar Produto A com preço 10 e quantidade 3 e Produto B com preço 20 e quantidade 2): Total esperado de R$ 70.00.

Teste 2 (Excluir o Produto A): Total esperado de R$ 40.00.

Teste 3 (Excluir todos os produtos): Total esperado de R$ 0.00.

Teste 4 (Cadastrar novamente A e B e editar a quantidade de B de 2 para 3): Total esperado de R$ 90.00.

## 3. Pergunta do exercício

**Por que um total fixado apenas no cadastro ficaria incorreto depois de uma edição?**

Porque o valor total depende do preço e da quantidade de cada produto. Se algum desses valores for alterado durante uma edição, o total anterior não corresponderá mais aos dados atualizados. Por isso, é necessário recalcular o total sempre que houver alguma alteração na lista.