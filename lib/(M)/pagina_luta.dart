import 'package:flutter/material.dart';
import '../rph_maker/personagem_model.dart';

class TelaLuta extends StatefulWidget {
  const TelaLuta({super.key});

  @override
  State<TelaLuta> createState() => _TelaLutaState();
}

class _TelaLutaState extends State<TelaLuta> {
  String cenarioSelecionado = '';

  final List<Map<String, dynamic>> cenarios = [
    {
      'nome': 'Floresta Escura',
      'icon': Icons.forest,
      'inimigos': ['Goblin', 'Lobo'],
      'cor': Colors.green[800],
    },
    {
      'nome': 'Caverna Goblin',
      'icon': Icons.dark_mode,
      'inimigos': ['Goblin Chefe', 'Goblin x2'],
      'cor': Colors.grey[700],
    },
    {
      'nome': 'Torre do Mago',
      'icon': Icons.castle,
      'inimigos': ['Elemental', 'Mago Sombrio'],
      'cor': Colors.purple[800],
    },
  ];

  final List<Personagem> personagens = [
    Personagem(
      nome: 'Nando',
      forca: 10,
      agilidade: 8,
      inteligencia: 6,
      classe: 'Guerreira',
      pvAtual: 35,
      pvMax: 35,
      ca: 18,
      imagem:
          'https://i.pinimg.com/736x/da/ba/ac/dabaac36c2b0bc1c56344f437a8ab5a3.jpg',
    ),
    Personagem(
      nome: 'Roric',
      forca: 10,
      agilidade: 8,
      inteligencia: 6,
      classe: 'Mago',
      pvAtual: 22,
      pvMax: 28,
      ca: 18,
      imagem:
          'https://i.pinimg.com/736x/3e/ac/18/3eac181bbef4ee9d9ef675d94ccc8d95.jpg',
    ),
    Personagem(
      nome: 'Lyra',
      forca: 10,
      agilidade: 8,
      inteligencia: 6,
      classe: 'Ladina',
      pvAtual: 30,
      pvMax: 30,
      ca: 18,
      imagem:
          'https://i.pinimg.com/736x/9a/8b/7c/9a8b7c6d5e4f3g2h1i0j9k8l7m6n5o4.jpg',
    ),
    Personagem(
      nome: 'Narya',
      forca: 10,
      agilidade: 8,
      inteligencia: 6,
      classe: 'Curador',
      pvAtual: 20,
      pvMax: 20,
      ca: 18,
      imagem:
          'https://i.pinimg.com/736x/3k/2j/1i/3k2j1i0h9g8f7e6d5c4b3a2z1y0x9w8.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preparar Luta'),
        backgroundColor: Colors.brown[800],
      ),
      body: Column(
        children: [
          // PARTE SUPERIOR - Personagens
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[900],
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Seus Personagens',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return buildCardPersonagem(personagens[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(color: Colors.amber),
          // PARTE INFERIOR - Cenários
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[900],
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Escolha um Cenário',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return buildCardCenario(cenarios[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // BOTÃO INICIAR LUTA
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton.icon(
              onPressed:
                  cenarioSelecionado.isNotEmpty
                      ? () {
                        // Navegar para tela de combate
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Iniciando luta em $cenarioSelecionado!',
                            ),
                          ),
                        );
                      }
                      : null,
              icon: const Icon(Icons.shield),
              label: const Text('Iniciar Luta'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[800],
                disabledBackgroundColor: Colors.grey[700],
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCardPersonagem(Personagem p) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.amber, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.amber[700],
            backgroundImage: NetworkImage(p.imagem),
          ),
          const SizedBox(height: 8),
          Text(
            p.nome,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            '❤️ ${p.pvAtual}/${p.pvMax}',
            style: const TextStyle(fontSize: 11, color: Colors.red),
          ),
          Text(
            '🛡️ ${p.ca}',
            style: const TextStyle(fontSize: 11, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget buildCardCenario(Map<String, dynamic> cenario) {
    bool selecionado = cenarioSelecionado == cenario['nome'];

    return GestureDetector(
      onTap: () {
        setState(() {
          cenarioSelecionado = cenario['nome'];
        });
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: cenario['cor'],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selecionado ? Colors.amber : Colors.transparent,
            width: 3,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(cenario['icon'], size: 40, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              cenario['nome'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Inimigos: ${cenario['inimigos'].length}',
              style: const TextStyle(fontSize: 11, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
