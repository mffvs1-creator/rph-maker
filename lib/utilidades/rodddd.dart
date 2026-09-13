import 'package:flutter/material.dart';
import 'MAPA MUNDIAL.dart' as gm;
import 'buncomap.dart';
import 'api_missoes.dart';
import 'missao_model.dart';

class Mapa extends StatefulWidget {
  const Mapa({super.key});

  @override
  State<Mapa> createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  final BancoMap _banco = BancoMap();
  List<Map<String, dynamic>> _locais = [];

  @override
  void initState() {
    super.initState();
    _carregarLocais();
  }

  Future<void> _carregarLocais() async {
    final dados = await _banco.listarLocais();
    setState(() {
      _locais = dados;
    });
  }

  Future<void> _alternarStatus(int id, int statusAtual) async {
    int novoStatus = statusAtual == 0 ? 1 : 0;
    await _banco.atualizarStatus(id, novoStatus);
    _carregarLocais();
  }

  void _abrirQuadroMissoes(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 400,
          child: Column(
            children: [
              const Text(
                'QUADRO DE MISSÕES',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E5B8B),
                  letterSpacing: 2,
                ),
              ),
              const Divider(color: Colors.white24),
              Expanded(
                child: FutureBuilder<List<Missao>>(
                  future: ApiMissoes().buscarMissoes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Erro: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('Nenhuma missão disponível no reino.'),
                      );
                    }

                    final missoes = snapshot.data!;
                    return ListView.builder(
                      itemCount: missoes.length,
                      itemBuilder: (context, i) {
                        final m = missoes[i];
                        return Card(
                          color: Colors.grey[900],
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: const Icon(Icons.assignment, color: Colors.amber),
                            title: Text(
                              m.titulo,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Recompensa: ${m.recompensa}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getColorDificuldade(m.dificulte),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                m.dificulte,
                                style: const TextStyle(fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getColorDificuldade(String diff) {
    switch (diff.toLowerCase()) {
      case 'fácil': return Colors.green;
      case 'média': return Colors.orange;
      case 'difícil': return Colors.red;
      default: return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E5B8B),
        title: const Center(
          child: Text(
            'Locais de Missões',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const gm.Map()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz4act6WAt1IBqYVCXoZtB2XWRd8rzMcTwN-HtCNCduQ&s',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: _locais.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _locais.length,
                itemBuilder: (context, index) {
                  final local = _locais[index];
                  bool marcado = local['marcado'] == 1;

                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      Image.network(
                        local['imagem'],
                        width: 300,
                        height: 250,
                        fit: BoxFit.contain,
                      ),
                      Text(
                        local['nome'],
                        style: const TextStyle(fontSize: 40, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => _alternarStatus(local['id'], local['marcado']),
                            icon: Icon(
                              marcado ? Icons.star : Icons.location_on,
                              size: 40,
                            ),
                            color: marcado ? Colors.yellowAccent : Colors.red,
                          ),
                          const SizedBox(width: 20),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber[800],
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () => _abrirQuadroMissoes(context),
                            icon: const Icon(Icons.list_alt),
                            label: const Text('VER MISSÕES'),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
