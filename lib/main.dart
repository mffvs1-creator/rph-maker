import 'package:flutter/material.dart';
import 'package:rpgmaker/home/login%20page.dart';
import 'package:rpgmaker/home/teia_inicial.dart';
import 'persona5/tela_personagens.dart';
import 'persona5/pagina_luta.dart';

void main() {
  runApp(const MeuAppRPG());
}

class MeuAppRPG extends StatelessWidget {
  const MeuAppRPG({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPH Maker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LoginPage(),
    );
  }
}