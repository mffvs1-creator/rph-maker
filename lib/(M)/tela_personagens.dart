import 'package:flutter/material.dart';

class TelaPersonagens extends StatelessWidget {
  const TelaPersonagens({super.key});

  Widget buildCircleAvatar(String imagem) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.amber[700],
      backgroundImage: NetworkImage(imagem),
    );
  }

  @override
  Widget build(BuildContext context) {
    // uma lista dos personagens
    final Telapersonagens = [
      {
        'nome': 'Juno',
        'classe': 'pistoleiro',
        'pv': '35/35',
        'ca': '18',
        'imagem':
            'https://i.pinimg.com/1200x/d6/59/01/d65901b6a4cd7b94f5c3ac943623e28d.jpg',
      },
      {
        'nome': 'Rein',
        'classe': 'Mago',
        'pv': '22/28',
        'ca': '18',
        'imagem':
            'https://i.pinimg.com/736x/c6/42/63/c64263a7a299f0b7dee3510109233768.jpg',
      },
      {
        'nome': 'Lyra',
        'classe': 'Ladina',
        'pv': '30/30',
        'ca': '18',
        'imagem':
            'https://i.pinimg.com/736x/42/40/30/4240306f84552588be338fceed5bd1b9.jpg',
      },
      {
        'nome': 'Narya',
        'classe': 'Curador',
        'pv': '20/20',
        'ca': '18',
        'imagem':
            'https://i.pinimg.com/1200x/34/28/aa/3428aa0ef52d25c869baff04d8f8be2e.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens'),
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
