import 'package:flutter/material.dart';
import 'package:rpgmaker/home_page.dart';
import 'Personagens/tela_personagens.dart';
import 'Personagens/pagina_luta.dart';

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
      home: const HomePage(),
    );
  }
}