import 'package:flutter/material.dart';
import '../api/classe.dart';
import '../api/classepi.dart';
import 'personagem_model.dart';
import 'personagem_dao.dart';


class TelaPersonagens extends StatefulWidget {
  final Classe? classes;

  const TelaPersonagens({super.key, this.classes});

  @override
  State<TelaPersonagens> createState() => _TelaPersonagensState();
}

class _TelaPersonagensState extends State<TelaPersonagens> {

  late Future<List<personagem>> _futurePersonagens;
  TextEditingController search = TextEditingController();
  PersonagemDao dao = PersonagemDao();
  ClasseApi api = ClasseApi();
  late Future<List<Classe>> futureclasses;
  bool _mostrarClasses = false;

  @override
  void initState() {
    super.initState();
    _futurePersonagens = Future.value([]);
    futureclasses = api.listarClasses();
  }

  void _toggleClasses() {
    setState(() {
      _mostrarClasses = !_mostrarClasses;
    });
  }

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
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: _mostrarClasses ? 'Ocultar classes' : 'Mostrar classes',
          onPressed: _toggleClasses,
        ),
        title: const Text('Personagens'),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SafeArea(
      child: Column(
        children: [
          if (_mostrarClasses)
            FutureBuilder<List<Classe>>(
              future: futureclasses,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Erro ao carregar classes: ${snapshot.error}'),
                  );
                }

                final lista = snapshot.data ?? [];
                if (lista.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Text('Nenhuma classe encontrada.'),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: lista.length,
                    itemBuilder: (context, index) {
                      final p = lista[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        color: const Color(0xFF2E5B8B),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            p.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          else
            const SizedBox.shrink(),
          Expanded(
            child: FutureBuilder<List<personagem>>(
              future: _futurePersonagens,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Erro ao carregar personagens: ${snapshot.error}'),
                  );
                }

                final lista = snapshot.data ?? [];
                if (lista.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum personagem encontrado.',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: lista.length,
                  itemBuilder: (context, index) {
                    final p = lista[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: const Color(0xFF2E5B8B),
                      child: ListTile(
                        leading: buildCircleAvatar(p.imagem),
                        title: Text(
                          p.nome,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        subtitle: Text(p.classe, style: const TextStyle(color: Colors.white70)),
                        trailing: Text(
                          'PV: ${p.pvAtual}/${p.pvMax}\nCA: ${p.ca}',
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 14, color: Colors.white),
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
  }
}