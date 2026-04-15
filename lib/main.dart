import 'package:flutter/material.dart';
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
      // agora a main puxa a tela_personagens
      home: const TelaPersonagens(),
    );
  }
}