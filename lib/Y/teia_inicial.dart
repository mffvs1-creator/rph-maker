import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

// APP PRINCIPAL
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RPG Maker',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
// TELA 1 - BEM VINDO
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/capa.png',
            fit: BoxFit.cover,
          ),

          Align(
            alignment: const Alignment(0, 0.3),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MenuScreen(),
                  ),
                );
              },
              child: Text(
                "Bem Vindo",
                style: GoogleFonts.poppins(
                  color: Color (0xFF003049),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// TELA 2 - MENU
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  Widget buildButton(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: 350,
        child: ElevatedButton(
          onPressed: () {
            if (text == "Créditos") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreditsScreen(),
                ),
              );
            }
          },
          child: Text(text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/menu.bg.png',
            fit: BoxFit.cover,
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildButton(context, "Mapas"),
              buildButton(context, "Fichas"),
              buildButton(context, "Dados"),
              buildButton(context, "Personagens"),
              buildButton(context, "Créditos"), // 👈 CONECTADO
            ],
          ),
        ],
      ),
    );
  }
}

// TELA DE CRÉDITOS
class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Créditos"),
        centerTitle: true,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "RPG Maker\n\n"
                "Desenvolvido por: Ycaro dos Reis Lima, Jéferson Gama da Silva, Rodrigo dos Santos, Marcus Fellype Firmino Vieira da Siva\n\n"
                "Projeto Flutter RPG\n\n"
                "Idea dada por: Eduardo Santos Mendes - Aluno da 413\n\n"
                "Feito para uma atividade de Programação Móvel do IFAL Arapiraca\n\n"
                "Versão: 1.0",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}