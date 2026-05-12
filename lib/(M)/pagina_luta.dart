import 'package:flutter/material.dart';
import 'personagem_model.dart';

class TelaLuta extends StatefulWidget {
  final List<personagem> personagens;

  const TelaLuta({super.key, required this.personagens});

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
                itemCount: widget.personagens.length,
                itemBuilder: (_, i) => _cardPersonagem(widget.personagens[i]),
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
                        SnackBar(
                          content: Text('Iniciando em $cenarioSelecionado!'),
                        ),
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
          Text(
            titulo,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(child: conteudo),
        ],
      ),
    );
  }

  Widget _cardPersonagem(personagem p) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFF2E5B8B)),
        color: Colors.grey[850],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Imagem do personagem
          CircleAvatar(
            radius: 28,
            backgroundColor: Color(0xFF2E5B8B),
            backgroundImage: p.imagem.isNotEmpty
                ? NetworkImage(p.imagem)
                : null,
            child: p.imagem.isEmpty
                ? const Icon(Icons.person, color: Colors.white)
                : null,
          ),
          const SizedBox(height: 6),
          // Nome
          Text(
            p.nome,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E5B8B),
              fontSize: 13,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          // Classe
          Text(
            p.classe,
            style: TextStyle(fontSize: 11, color: Colors.grey[400]),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          // PV
          Text(
            'PV: ${p.pvAtual}/${p.pvMax}',
            style: const TextStyle(fontSize: 11, color: Color(0xFF2E5B8B)),
          ),
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
            color: selecionado ? Color(0xFF2E5B8B) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(cenario['icon'], color: Color(0xFF2E5B8B)),
            Text(
              cenario['nome'],
              style: const TextStyle(color: Color(0xFF2E5B8B)),
            ),
          ],
        ),
      ),
    );
  }
}