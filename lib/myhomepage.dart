import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'cadastrarpessoa.dart';
import 'database_helper.dart';
import 'detalhes_aniversario.dart';
import 'listaraniversarios.dart';
import 'pessoa.dart';

class MyHomePage extends StatefulWidget {
  static const nomeRota = "/myhomepage"; //ESSE É O NOME DA ROTA

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    print("começou build MyHomePage");
    return Scaffold(
      drawer: _buildMenu(),
      appBar: AppBar(title: const Text("Aniversariantes de Hoje !")),
      body: _listaAniversariantes(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            //Icones podem ser consultados em
            // https://api.flutter.dev/flutter/material/Icons-class.html
            icon: Icon(Icons.email),
            label: 'Email',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Telefone'),
        ],
        backgroundColor: Colors.blue,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildMenu() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            //Se não colocar isso, a barra azul fica muito grande (altura)
            height: 80.0,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Opções'),
            ),
          ),
          ListTile(
            title: const Text('Cadastrar Pessoa'),
            onTap: () {
              Navigator.pushNamed(context, CadastrarPessoa.nomeRota);
            },
          ),
          ListTile(
            title: const Text('Listar Aniversarios'),
            onTap: () {
              Navigator.pushNamed(context, ListarAniversarios.nomeRota);
            },
          ),
        ],
      ),
    );
  }

  Widget _listaAniversariantes() {
    //Aqui você pode implementar a lógica para listar os aniversariantes do dia
    return Center(
      child: FutureBuilder<List?>(
        future: _consultar(),
        initialData: List.empty(), //Cria uma lista vazia
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    Pessoa pessoa = snapshot.data![i];
                    if (_ehAniversariante(pessoa)) {
                      return _buildRow(context, pessoa);
                    } else {
                      return const SizedBox.shrink(); // Retorna um widget vazio
                    }
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

  bool _ehAniversariante(Pessoa p) {
    DateTime hoje = DateTime.now();
    var customFormatter = DateFormat('dd/MM/yyyy');
    DateTime dataAniversario = customFormatter.parse(p.aniversario!);
    bool teste =
        (hoje.day == dataAniversario.day &&
        hoje.month == dataAniversario.month);
    assert(teste == true, "Erro ao verificar aniversariante");
    return teste;
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
