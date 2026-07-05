
import 'package:flutter/material.dart';
import 'package:rpgmaker/persona5/db_helperpersonagens.dart';
import 'utilidades/dados.dart';
import 'persona5/pagina_luta.dart';
import 'persona5/personagem_model.dart';
import 'persona5/tela_personagens.dart';
import 'persona5/fichas.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    DBHelperpersonagens().initDB(); // Inicializa o banco de dados ao iniciar o aplicativo
  }
  // Lista centralizada de personagens
  final List<personagem> personagens = [
    personagem(
      nome: 'Julio',
      classe: 'Guerreiro',
      pvAtual: 35,
      pvMax: 35,
      forca: 10,
      agilidade: 8,
      inteligencia: 6,
      ca: 18,
      imagem: 'https://i.pinimg.com/736x/eb/01/04/eb01044783b72a4140d5fa80ec28f104.jpg',
    ),
    personagem(
      nome: 'Elara',
      classe: 'Arqueira',
      pvAtual: 22,
      pvMax: 22,
      forca: 10,
      agilidade: 8,
      inteligencia: 6,
      ca: 18,
      imagem: 'https://cdn.rafled.com/anime-icons/images/sN5EGhvu8EvZA35RXmT3tU8jQwOalzqK.jpg',
    ),
    personagem(
      nome: 'Lysandra',
      classe: 'Curandeira',
      pvAtual: 10,
      pvMax: 10,
      forca: 10,
      agilidade: 8,
      inteligencia: 6,
      ca: 18,
      imagem: 'https://cdn.rafled.com/anime-icons/images/f2avsZPYjzdLGSjT1Jrp63aKhRT8yyCW.jpg',
    ),
    personagem(
      nome: 'Kael',
      classe: 'InvocadorMaterial',
      pvAtual: 30,
      pvMax: 30,
      forca: 15,
      agilidade: 10,
      inteligencia: 10,
      ca: 18,
      imagem: 'https://images.cults3d.com/oB-W8h92wqml1soy2CeP5KL3gQQ=/516x516/filters:no_upscale():format(webp)/https://fbi.cults3d.com/uploaders/15449960/illustration-file/771a0ee5-c7a4-49c5-8b3a-6aea9fd34e31/images-2025-09-21T182621.668.jpg',
    ),
    personagem(
        nome: 'Thor',
        classe: 'Shamam',
        pvAtual: 20,
        pvMax: 20,
        forca: 10,
        agilidade: 8,
        inteligencia: 6,
        ca: 18,
        imagem:'https://pbs.twimg.com/profile_images/1052260285111779334/B_ME7cF8_400x400.jpg'
    ),
  ];

  int selectedIndex = 0;

  late List pages = [
    TelaPersonagens(),
    TelaLuta(personagens: personagens),
    DiceRollerHome(),
    Ficha(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        backgroundColor: Colors.brown[800],
        selectedItemColor: Color(0xFF2E5B8B),
        unselectedItemColor: Colors.grey,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Personagens',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.shield), label: 'Luta'),
          BottomNavigationBarItem(icon: Icon(Icons.casino), label: 'Dados'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'Fichas')
        ],
      ),
    );
  }
}
