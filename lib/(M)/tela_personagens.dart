import 'package:flutter/material.dart';
import 'personagem_model.dart';


class TelaPersonagens extends StatefulWidget {
  const TelaPersonagens({super.key});


  @override
  State<TelaPersonagens> createState() => _TelaPersonagensState();
}

class _TelaPersonagensState extends State<TelaPersonagens> {

  // Lista centralizada de personagens
  static final List<personagem> personagens = [
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

  Widget buildCircleAvatar(String imagem) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Color(0xFF2E5B8B),
      backgroundImage: NetworkImage(imagem),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens'),
        backgroundColor: Color(0xFF2E5B8B),
      ),
      body: buildBody()
    );
  }

  Widget buildBody(){
    return ListView.builder(
      itemCount: personagens.length,
      itemBuilder: (context, index) {
        final p = personagens[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          color: Color(0xFF2E5B8B),
          child: ListTile(
            leading: buildCircleAvatar(p.imagem),
            title: Text(
              p.nome,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(p.classe),
            trailing: Text(
              'PV: ${p.pvAtual}/${p.pvMax}\nCA: ${p.ca}',
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 14, color: Color(0xFF2E5B8B)),
            ),
            ),
          );
      },
    );
  }
}