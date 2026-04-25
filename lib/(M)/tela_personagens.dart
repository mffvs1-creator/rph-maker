import 'package:flutter/material.dart';

class TelaPersonagens extends StatelessWidget {
  const TelaPersonagens({super.key});

  Widget buildCircleAvatar(String imagem) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.amber[700],
      backgroundImage: NetworkImage(imagem),
    );
  }

  @override
  Widget build(BuildContext context) {
    // uma lista dos personagens
    final Telapersonagens = [
      {
        'nome': 'Julio',
        'classe': 'Guerreiro',
        'pv': '35/35',
        'ca': '18',
        'imagem':
            'https://i.pinimg.com/736x/eb/01/04/eb01044783b72a4140d5fa80ec28f104.jpg',
      },
      {
        'nome': 'Elara',
        'classe': 'arqueira',
        'pv': '22/22',
        'ca': '18',
        'imagem':
            'https://cdn.rafled.com/anime-icons/images/sN5EGhvu8EvZA35RXmT3tU8jQwOalzqK.jpg',
      },
      {
        'nome': 'Lysandra',
        'classe': 'curandeira',
        'pv': '10/10',
        'ca': '18',
        'imagem':
            'https://cdn.rafled.com/anime-icons/images/f2avsZPYjzdLGSjT1Jrp63aKhRT8yyCW.jpg',
      },
      {
        'nome': 'Kael',
        'classe': 'invocador',
        'pv': '20/20',
        'ca': '18',
        'imagem':
            'https://images.cults3d.com/oB-W8h92wqml1soy2CeP5KL3gQQ=/516x516/filters:no_upscale():format(webp)/https://fbi.cults3d.com/uploaders/15449960/illustration-file/771a0ee5-c7a4-49c5-8b3a-6aea9fd34e31/images-2025-09-21T182621.668.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('TelaPersonagens'),
        backgroundColor: Colors.brown[800],
      ),
      body: ListView.builder(
        itemCount: Telapersonagens.length,
        itemBuilder: (context, index) {
          final p = Telapersonagens[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.grey[850],
            child: ListTile(
              leading: buildCircleAvatar(p['imagem']!),
              title: Text(
                p['nome']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(p['classe']!),
              trailing: Text(
                'PV: ${p['pv']}\nCA: ${p['ca']}',
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Personagens',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.casino), label: 'Dados'),
        ],
      ),
    );
  }
}

buildCircleAvatar(String imagem, {required Widget leading}) {
  return CircleAvatar(
    backgroundColor: Colors.transparent,
    radius: 30,
    backgroundImage: NetworkImage(imagem),
    onBackgroundImageError: (exception, stackTrace) {
      // Fallback para erro de imagem
      debugPrint('Erro ao carregar imagem: $exception');
    },
  );
}
