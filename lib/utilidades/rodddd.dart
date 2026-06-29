import 'package:flutter/material.dart';
import 'MAPA MUNDIAL.dart' as gm;
import 'buncomap.dart';

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
