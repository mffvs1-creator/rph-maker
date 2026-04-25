import 'package:flutter/material.dart';
import '../rph_maker/personagem_model.dart';

class TelaLuta extends StatefulWidget {
  const TelaLuta({super.key});

  @override
  State<TelaLuta> createState() => _TelaLutaState();
}

class _TelaLutaState extends State<TelaLuta> {
  String cenarioSelecionado = '';

  final cenarios = [
    {'nome': 'Floresta', 'icon': Icons.forest, 'cor': Colors.green},
    {'nome': 'Caverna', 'icon': Icons.dark_mode, 'cor': Colors.grey},
    {'nome': 'Torre', 'icon': Icons.castle, 'cor': Colors.purple},
  ];

  final personagens = [
  Personagem(nome: 'Nando', classe: 'Guerreira', pvAtual: 35, pvMax: 35, forca: 10, agilidade: 8, inteligencia: 6, ca: 18, imagem: ''),
  Personagem(nome: 'Roric', classe: 'Mago', pvAtual: 22, pvMax: 28, forca: 10, agilidade: 8, inteligencia: 6, ca: 18, imagem: ''),
  Personagem(nome: 'Lyra', classe: 'Ladina', pvAtual: 30, pvMax: 30, forca: 10, agilidade: 8, inteligencia: 6, ca: 18, imagem: ''),
  Personagem(nome: 'Narya', classe: 'Curador', pvAtual: 20, pvMax: 20, forca: 10, agilidade: 8, inteligencia: 6, ca: 18, imagem: ''),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preparar Luta')),
      body: Column(
        children: [
          // Personagens
          Expanded(
            flex: 2,
            child: _buildSecao(
              'Seus Personagens',
              ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: personagens.length,
                itemBuilder: (_, i) => _cardPersonagem(personagens[i]),
              ),
            ),
          ),
          const Divider(),
          // Cenários
          Expanded(
            flex: 2,
            child: _buildSecao(
              'Escolha um Cenário',
              ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cenarios.length,
                itemBuilder: (_, i) => _cardCenario(cenarios[i]),
              ),
            ),
          ),
          // Botão
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton.icon(
              onPressed: cenarioSelecionado.isNotEmpty
                  ? () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Iniciando em $cenarioSelecionado!')),
                      )
                  : null,
              icon: const Icon(Icons.shield),
              label: const Text('Iniciar Luta'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecao(String titulo, Widget conteudo) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(child: conteudo),
        ],
      ),
    );
  }

  Widget _cardPersonagem(Personagem p) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(p.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('${p.pvAtual}/${p.pvMax}', style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  Widget _cardCenario(Map<String, dynamic> cenario) {
    bool selecionado = cenarioSelecionado == cenario['nome'];
    return GestureDetector(
      onTap: () => setState(() => cenarioSelecionado = cenario['nome']),
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: cenario['cor'],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selecionado ? Colors.amber : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(cenario['icon'], color: Colors.white),
            Text(cenario['nome'], style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
