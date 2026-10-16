
import 'package:flutter/material.dart';

void main() => runApp(const MeuApp());

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaProdutos(),
    );
  }
}

class Produto {
  final String nome;
  final double preco;
  final String descricao;
  final int quantidade;

  const Produto({
    required this.nome,
    required this.preco,
    required this.descricao,
    required this.quantidade,
  });
}

class TelaProdutos extends StatefulWidget {
  const TelaProdutos({super.key});

  @override
  State<TelaProdutos> createState() => _TelaProdutosState();
}

class _TelaProdutosState extends State<TelaProdutos> {
  final List<Produto> produtos = [];

  // Exercício 8: campo de busca
  final buscaController = TextEditingController();
  String busca = '';

  double calcularTotalEstoque() {
    double total = 0;
    for (final produto in produtos) {
      total = total + (produto.preco * produto.quantidade);
    }
    return total;
  }

  void avisar(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  Future<void> cadastrar() async {
    final List<String> nomesExistentes = [];
    for (final produto in produtos) {
      nomesExistentes.add(produto.nome);
    }

    final novo = await Navigator.push<Produto>(
      context,
      MaterialPageRoute<Produto>(
        builder: (_) => TelaFormulario(
          nomesExistentes: nomesExistentes,
        ),
      ),
    );

    if (!mounted || novo == null) return;

    setState(() {
      produtos.add(novo);
    });

    avisar('Produto cadastrado com sucesso.');
  }

  Future<void> abrirDetalhes(int indice) async {
    final List<String> nomesOutrosProdutos = [];

    for (int i = 0; i < produtos.length; i++) {
      if (i != indice) {
        nomesOutrosProdutos.add(produtos[i].nome);
      }
    }

    final atualizado = await Navigator.push<Produto>(
      context,
      MaterialPageRoute<Produto>(
        builder: (_) => TelaDetalhes(
          produto: produtos[indice],
          nomesOutrosProdutos: nomesOutrosProdutos,
        ),
      ),
    );

    if (!mounted || atualizado == null) return;

    setState(() {
      produtos[indice] = atualizado;
    });

    avisar('Produto atualizado.');
  }

  Future<void> excluir(int indice) async {
    final produto = produtos[indice];

    final confirmou = await showDialog<bool>(
      context: context,
      builder: (contextoDialogo) => AlertDialog(
        title: const Text('Excluir produto'),
        content: Text('Deseja excluir ${produto.nome}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(contextoDialogo, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(contextoDialogo, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (!mounted || confirmou != true) return;

    setState(() {
      produtos.removeAt(indice);
    });

    avisar('Produto excluído.');
  }

  @override
  void dispose() {
    buscaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Exercício 8: lista filtrada
    final List<Produto> produtosFiltrados = [];

    for (final produto in produtos) {
      if (produto.nome.toLowerCase().contains(
            busca.trim().toLowerCase(),
          )) {
        produtosFiltrados.add(produto);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Produtos em memória')),
      body: Column(
        children: [
          // Exercício 8: campo de busca
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: buscaController,
              decoration: const InputDecoration(
                labelText: 'Buscar produto',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (valor) {
                setState(() {
                  busca = valor;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: Column(
              children: [
                Text('Produtos cadastrados: ${produtos.length}'),
                // Exercício 8: indicador de encontrados
                Text('Produtos encontrados: ${produtosFiltrados.length}'),
                const SizedBox(height: 8),
                Text(
                  'Valor total do estoque: R\$ ${calcularTotalEstoque().toStringAsFixed(2)}',
                ),
              ],
            ),
          ),
          Expanded(
            child: produtos.isEmpty
                ? const Center(
                    child: Text('Nenhum produto cadastrado.'),
                  )
                : produtosFiltrados.isEmpty
                    ? const Center(
                        child: Text('Nenhum produto encontrado.'),
                      )
                    : ListView.builder(
                        itemCount: produtosFiltrados.length,
                        itemBuilder: (context, indice) {
                          final produto = produtosFiltrados[indice];

                          // Exercício 8: localizar índice original
                          final indiceOriginal = produtos.indexOf(produto);

                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            child: ListTile(
                              title: Text(produto.nome),
                              subtitle: Text(
                                'Preço: R\$ ${produto.preco.toStringAsFixed(2)}'
                                ' | Quantidade: ${produto.quantidade}'
                                '\nTotal: R\$ ${(produto.preco * produto.quantidade).toStringAsFixed(2)}',
                              ),
                              onTap: () => abrirDetalhes(indiceOriginal),
                              trailing: IconButton(
                                tooltip: 'Excluir produto',
                                icon: const Icon(Icons.delete),
                                onPressed: () => excluir(indiceOriginal),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: cadastrar,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TelaDetalhes extends StatelessWidget {
  final Produto produto;
  final List<String> nomesOutrosProdutos;

  const TelaDetalhes({
    super.key,
    required this.produto,
    required this.nomesOutrosProdutos,
  });

  Future<void> editar(BuildContext context) async {
    final atualizado = await Navigator.push<Produto>(
      context,
      MaterialPageRoute<Produto>(
        builder: (_) => TelaFormulario(
          produto: produto,
          nomesExistentes: nomesOutrosProdutos,
        ),
      ),
    );

    if (!context.mounted || atualizado == null) return;
    Navigator.pop(context, atualizado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes do produto')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              produto.nome,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 12),
            Text('R\$ ${produto.preco.toStringAsFixed(2)}'),
            const SizedBox(height: 12),
            Text('Quantidade: ${produto.quantidade}'),
            const SizedBox(height: 12),
            Text(
              produto.descricao.isEmpty
                  ? 'Sem descrição.'
                  : produto.descricao,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => editar(context),
              child: const Text('Editar'),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaFormulario extends StatefulWidget {
  final Produto? produto;
  final List<String> nomesExistentes;

  const TelaFormulario({
    super.key,
    this.produto,
    required this.nomesExistentes,
  });

  @override
  State<TelaFormulario> createState() => _TelaFormularioState();
}

class _TelaFormularioState extends State<TelaFormulario> {
  final chave = GlobalKey<FormState>();

  late final TextEditingController nomeController;
  late final TextEditingController precoController;
  late final TextEditingController descricaoController;
  late final TextEditingController quantidadeController;

  @override
  void initState() {
    super.initState();
    final produto = widget.produto;

    nomeController = TextEditingController(
      text: produto?.nome ?? '',
    );
    precoController = TextEditingController(
      text: produto?.preco.toString() ?? '',
    );
    descricaoController = TextEditingController(
      text: produto?.descricao ?? '',
    );
    quantidadeController = TextEditingController(
      text: produto?.quantidade.toString() ?? '',
    );
  }

  double? converterPreco(String texto) {
    return double.tryParse(texto.trim().replaceAll(',', '.'));
  }

  String? validarNome(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Informe o nome.';
    }
    if (valor.trim().length < 3) {
      return 'O nome deve ter pelo menos três caracteres.';
    }

    for (final nome in widget.nomesExistentes) {
      if (nome.trim().toLowerCase() == valor.trim().toLowerCase()) {
        return 'Já existe um produto com esse nome.';
      }
    }
    return null;
  }

  String? validarPreco(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Informe o preço.';
    }

    final preco = converterPreco(valor);
    if (preco == null || !preco.isFinite) {
      return 'Digite um número válido.';
    }
    if (preco <= 0) {
      return 'O preço deve ser maior que zero.';
    }
    return null;
  }

  String? validarQuantidade(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Informe a quantidade.';
    }

    final quantidade = int.tryParse(valor.trim());

    if (quantidade == null) {
      return 'Digite uma quantidade inteira válida.';
    }
    if (quantidade < 0) {
      return 'A quantidade não pode ser negativa.';
    }
    return null;
  }

  void salvar() {
    if (!chave.currentState!.validate()) return;

    final produto = Produto(
      nome: nomeController.text.trim(),
      preco: converterPreco(precoController.text)!,
      descricao: descricaoController.text.trim(),
      quantidade: int.tryParse(quantidadeController.text.trim())!,
    );

    Navigator.pop(context, produto);
  }

  @override
  void dispose() {
    nomeController.dispose();
    precoController.dispose();
    descricaoController.dispose();
    quantidadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.produto != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          editando ? 'Editar produto' : 'Cadastrar produto',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: chave,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: validarNome,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: precoController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Preço'),
                validator: validarPreco,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição opcional',
                ),
                validator: (valor) {
                  if (valor != null && valor.trim().length > 120) {
                    return 'A descrição deve ter no máximo 120 caracteres.';
                  }
                  return null;
                },
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: quantidadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Quantidade'),
                validator: validarQuantidade,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: salvar,
                child: const Text('Salvar'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
