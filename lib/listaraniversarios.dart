import 'package:flutter/material.dart';
import 'detalhes_aniversario.dart';
import 'database_helper.dart';
import 'pessoa.dart';

class ListarAniversarios extends StatefulWidget {
  static const nomeRota = "/listaraniversarios";

  const ListarAniversarios({super.key});

  @override
  _ListarAniversarioState createState() => _ListarAniversarioState();
}

class _ListarAniversarioState extends State<ListarAniversarios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aniversários Cadastrados')),
      body: FutureBuilder<List?>(
        future: _consultar(),
        initialData: List.empty(), //Cria uma lista vazia
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    Pessoa pessoa = snapshot.data![i];
                    assert(pessoa.id != null, "Id da pessoa é nulo");
                    return _buildRow(context, pessoa);
                  },
                )
              : const Center(
                  //para o caso de resultar null da pesquisa
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Column _buildRow(BuildContext context, Pessoa pessoa) {
    //var nomeInicial = pessoa.nome![0].toUpperCase();
    return Column(
      children: [
        ListTile(
          leading: ClipOval(
            child: Container(
              color: Colors.blue,
              width: 30,
              height: 30,
              child: Center(
                child: Text(
                  pessoa.id.toString(),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          title: Text(pessoa.nome!),
          dense: true,
          onTap: () {
            Navigator.pushNamed(
              context,
              DetalhesAniversario.nomeRota,
              arguments: pessoa,
            );
          },
        ),
      ],
    );
  }

  Future<List<Pessoa>?> _consultar() async {
    var db = DatabaseHelper.instance;
    return db.pesquisarTodasPessoas();
  }
}
