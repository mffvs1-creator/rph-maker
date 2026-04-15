import 'package:flutter/material.dart';
import '(M)/rph_maker/tela_personagens.dart';
import '(M)/tela_personagens.dart';

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
      // Aqui a main simplesmente "chama" a sua tela separada
      home: const TelaPersonagens(),
    );
  }
}