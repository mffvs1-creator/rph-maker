import 'package:flutter/material.dart';
import 'pagina_luta.dart';
import '../rph_maker/personagem_model.dart';

class TelaPersonagens extends StatelessWidget {
  const TelaPersonagens({super.key});

  // Lista centralizada de personagens
  static final List<Personagem> personagens = [
    Personagem(
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
    Personagem(
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
    Personagem(
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
    Personagem(
      nome: 'Kael',
      classe: 'Invocador',
      pvAtual: 20,
      pvMax: 20,
      forca: 10,
      agilidade: 8,
      inteligencia: 6,
      ca: 18,
      imagem: 'https://images.cults3d.com/oB-W8h92wqml1soy2CeP5KL3gQQ=/516x516/filters:no_upscale():format(webp)/https://fbi.cults3d.com/uploaders/15449960/illustration-file/771a0ee5-c7a4-49c5-8b3a-6aea9fd34e31/images-2025-09-21T182621.668.jpg',
    ),
  ];

  Widget buildCircleAvatar(String imagem) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.amber[700],
      backgroundImage: NetworkImage(imagem),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens'),
        backgroundColor: Colors.brown[800],
      ),
      body: ListView.builder(
        itemCount: personagens.length,
        itemBuilder: (context, index) {
          final p = personagens[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.grey[850],
            child: ListTile(
              leading: buildCircleAvatar(p.imagem),
              title: Text(
                p.nome,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(p.classe),
              trailing: Text(
                'PV: ${p.pvAtual}/${p.pvMax}\nCA: ${p.ca}',
                style: const TextStyle(fontSize: 14, color: Colors.amber),
                textAlign: TextAlign.right,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.brown[800],
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TelaLuta(personagens: personagens),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Personagens',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.shield), label: 'Luta'),
          BottomNavigationBarItem(icon: Icon(Icons.casino), label: 'Dados'),
        ],
      ),
    );
  }
}