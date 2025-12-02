import 'package:flutter/material.dart';
import 'cadastrarpessoa.dart';
import 'confirma_cadastro.dart';
import 'detalhes_aniversario.dart';
import 'listaraniversarios.dart';
import 'myhomepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda de Aniversários',
      theme: ThemeData(primarySwatch: Colors.blue),
      // SAi o home e entram as rotas de navegação
      initialRoute: MyHomePage.nomeRota,
      routes: {
        //CadastrarPessoa.nomeRota: (context) => CadastrarPessoa(),
        CadastrarPessoa.nomeRota: (context) => CadastrarPessoa(),
        ConfirmaCadastro.nomeRota: (context) => ConfirmaCadastro(),
        DetalhesAniversario.nomeRota: (context) => DetalhesAniversario(),
        ListarAniversarios.nomeRota: (context) => ListarAniversarios(),
        MyHomePage.nomeRota: (context) => MyHomePage(),
      },
    );
  }
}
