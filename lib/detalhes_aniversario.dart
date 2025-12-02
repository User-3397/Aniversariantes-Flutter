import 'package:flutter/material.dart';
import 'myhomepage.dart';
import 'pessoa.dart';

class DetalhesAniversario extends StatelessWidget {
  static const nomeRota = "/detalhesaniversario";

  @override
  Widget build(BuildContext context) {
    //NOVO - Recebe os argumentos passados na navegação
    RouteSettings? route = ModalRoute.of(context)!.settings;
    Pessoa? argumentos = route.arguments as Pessoa; // NOVO

    // String nome = argumentos!.nome ?? "Nome não informado";
    // String email = argumentos.email ?? "Email não informado";
    // String telefone = argumentos.telefone ?? "Telefone não informado";
    // String aniversario = argumentos.aniversario ?? "Aniversário não informado";
    // String categoria = argumentos.categoria ?? "Categoria não informada";

    final TextScaler textScaler = MediaQuery.textScalerOf(context);

    // 2. Usar o método .scale() para calcular o novo tamanho
    final double baseFontSize = 16.0;
    final double scaledFontSize = textScaler.scale(baseFontSize);

    return Scaffold(
      appBar: AppBar(title: const Text('Dados do Aniversariante')),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: Text(
                argumentos.nome!.substring(0, 1),
                style: TextStyle(fontSize: scaledFontSize * 4),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              argumentos.nome!,
              style: TextStyle(fontSize: scaledFontSize * 2),
            ),
            const SizedBox(height: 20),
            Text(argumentos.email!, style: TextStyle(fontSize: scaledFontSize)),
            const SizedBox(height: 20),
            Text(
              argumentos.telefone!,
              style: TextStyle(fontSize: scaledFontSize),
            ),
            const SizedBox(height: 20),
            Text(
              argumentos.aniversario!,
              style: TextStyle(fontSize: scaledFontSize),
            ),
            const SizedBox(height: 20),
            Text(
              argumentos.categoria!,
              style: TextStyle(fontSize: scaledFontSize),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyHomePage.nomeRota);
              },
              child: const Text('Voltar para a tela inicial'),
            ),
          ],
        ),
      ),
    );
  } // build
} // class
