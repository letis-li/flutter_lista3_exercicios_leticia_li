# Exercício 09 — Dar uma identidade estável aos registros

## 1. Alterações realizadas

Foi adicionado o atributo `id` do tipo `int` à classe `Produto`, permitindo identificar cada registro de forma independente de sua posição na lista.

Também foi criado o contador `proximoId`, que atribui um identificador a cada novo produto cadastrado. Esse contador aumenta somente após um cadastro aceito e não diminui quando um produto é excluído.

As operações de edição e exclusão passaram a utilizar `indexWhere()` para localizar o registro pelo seu `id`, evitando problemas com os índices da lista filtrada.

A edição mantém o identificador original do produto e, quando um registro não é encontrado, a operação é interrompida com uma mensagem de aviso, sem acessar uma posição inválida.

## 2. Testes

Teste 1 (Cadastrar Mouse, Teclado e Monitor): Os produtos devem receber, respectivamente, os IDs 1, 2 e 3.

Teste 2 (Excluir Teclado, de ID 2): O produto deve ser removido, mantendo Mouse com ID 1 e Monitor com ID 3.

Teste 3 (Cadastrar um novo produto após excluir o ID 2): O novo produto deve receber ID 4, sem reutilizar o identificador excluído.

Teste 4 (Buscar Monitor e editar seu preço): Apenas o produto de ID 3 deve ser atualizado, mantendo seu identificador original.

Teste 5 (Cancelar uma edição): O produto deve continuar com o mesmo ID e os dados anteriores.

Teste 6 (Excluir um produto com filtro ativo): Somente o produto selecionado deve ser removido, preservando os demais registros.