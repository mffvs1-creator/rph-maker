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
    final personagens = [
  {
    'nome': 'Nando',
    'classe': 'Guerreira',
    'pv': '35/35',
    'ca': '18',
    'imagem': 'https://i.pinimg.com/736x/da/ba/ac/dabaac36c2b0bc1c56344f437a8ab5a3.jpg'
  },
  {
    'nome': 'Roric',
    'classe': 'Mago',
    'pv': '22/28',
    'ca': '18',
    'imagem': 'https://i.pinimg.com/736x/3e/ac/18/3eac181bbef4ee9d9ef675d94ccc8d95.jpg'
  },
  {
    'nome': 'Lyra',
    'classe': 'Ladina',
    'pv': '30/30',
    'ca': '18',
    'imagem': 'https://i.pinimg.com/736x/9a/8b/7c/9a8b7c6d5e4f3g2h1i0j9k8l7m6n5o4.jpg'
  },
  {
    'nome': 'Narya',
    'classe': 'Curador',
    'pv': '20/20',
    'ca': '18',
    'imagem': 'https://i.pinimg.com/736x/3k/2j/1i/3k2j1i0h9g8f7e6d5c4b3a2z1y0x9w8.jpg'
  },
];

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
              leading: buildCircleAvatar(
                'https://i.pinimg.com/736x/da/ba/ac/dabaac36c2b0bc1c56344f437a8ab5a3.jpg',
              ),
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
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Regras'),
          BottomNavigationBarItem(icon: Icon(Icons.casino), label: 'Dados'),
        ],
      ),
    );
  }
}

    buildCircleAvatar(String imagem) {
      return CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 30,
        backgroundImage: NetworkImage(imagem),
        onBackgroundImageError: (exception, stackTrace) {
          // Fallback para erro de imagem
          debugPrint('Erro ao carregar imagem: $exception');
        },
        child: const Icon(Icons.person, size: 40, color: Colors.amber),
      );
    }

