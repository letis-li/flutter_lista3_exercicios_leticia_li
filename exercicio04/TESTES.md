# Exercício 03 —  Cancelamento sem efeitos colaterais

## 1. Alterações realizadas

Nenhuma. Foi-se utilizado o código do exercício 3.

## 2. Testes

Mouse, preço 50, tentar editar para Teclado a 100 e CANCELE: 
Mouse a 50 permaneceu.


## 3. Explicação

Cancelar cadastro > Impede que o produto seja cadastrado quando não há um produto retornado (novo == null) ou quando a tela não está mais ativa (!mounted).
`if (!mounted || novo == null) return;`
Se uma dessas condições for verdadeira, a operação é interrompida pelo return, mantendo a lista de produtos sem alterações.

Cancelar edição > Ao clicar no botão Cancelar, impede que as alterações feitas no formulário de edição sejam salvas ou enviadas para a tela principal, preservando os dados originais do produto.
`if (!context.mounted || atualizado == null) return;`
Quando a edição é cancelada, atualizado recebe null e a operação é interrompida, mantendo o produto com seus dados anteriores.

Cancelar exclusão > Ao clicar no botão Cancelar ou fechar a janela sem confirmar, impede que o produto seja excluído, mantendo o registro na lista.
`if (!mounted || confirmou != true) return;`
A exclusão só acontece quando o usuário confirma a operação. Caso contrário, o return interrompe a execução e o produto permanece cadastrado.
