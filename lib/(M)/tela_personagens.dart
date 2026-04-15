import 'package:flutter/material.dart';


class TelaPersonagens extends StatelessWidget {
  const TelaPersonagens({super.key});

  @override
  Widget build(BuildContext context) {
    // uma lista dos personagens
    final personagens = [
      {'nome': 'Elara', 'classe': 'Guerreira', 'pv': '35/35', 'ca': '18'},
      {'nome': 'Roric', 'classe': 'Mago', 'pv': '22/28', 'ca': '18'},
      {'nome': 'Lyra', 'classe': 'Ladina', 'pv': '30/30', 'ca': '18'},
      {'nome': 'Narya', 'classe': 'curador', 'pv': '20/20', 'ca': '18'},
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
              leading: const Icon(Icons.heart_broken, size: 35, color: Colors.white54),
              title: Text(p['nome']!, style: const TextStyle(fontWeight: FontWeight.bold)),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown[800],
        onPressed: () {
          // Ação de adicionar personagem
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}