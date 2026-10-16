# Exercício 08 — Buscar e editar o produto correto

## 1. Alterações realizadas

Foi adicionado um campo de busca por nome, utilizando `TextEditingController` e `onChanged` para atualizar a lista conforme o usuário digita.

A busca utiliza `toLowerCase()` para desconsiderar diferenças entre letras maiúsculas e minúsculas. Quando o campo está vazio, todos os produtos são apresentados.

Também foram adicionados indicadores de produtos cadastrados e encontrados, além da mensagem "Nenhum produto encontrado." quando a busca não retorna resultados.

Para garantir que a edição e a exclusão sejam realizadas no produto correto, foi utilizado `indexOf()` para localizar o registro original, evitando utilizar diretamente o índice da lista filtrada.

## 2. Testes

Teste 1 (Cadastrar Mouse, Teclado e Monitor e deixar a busca vazia): Os três produtos devem aparecer na lista.

Teste 2 (Buscar Teclado): Apenas Teclado deve aparecer, com três produtos cadastrados e um encontrado.

Teste 3 (Editar o preço de Teclado com o filtro ativo): Somente Teclado deve ser atualizado, mantendo Mouse e Monitor sem alterações.

Teste 4 (Buscar mouse utilizando letras minúsculas): O produto Mouse deve ser encontrado normalmente.

Teste 5 (Buscar um nome inexistente): Deve apresentar "Nenhum produto encontrado." e indicar zero produtos encontrados.

Teste 6 (Excluir Teclado com o filtro ativo): Somente Teclado deve ser removido, mantendo os outros dois produtos cadastrados.