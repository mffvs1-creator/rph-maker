import 'package:flutter/material.dart';
import '../api/classe.dart';
import '../api/classepi.dart';
import 'personagem_model.dart';
import 'personagem_dao.dart';


class TelaPersonagens extends StatefulWidget {
  Classe classes;
  TelaPersonagens({super.key, required this.classes});
  @override
  State<TelaPersonagens> createState() => _TelaPersonagensState();
}

class _TelaPersonagensState extends State<TelaPersonagens> {

  late Future<List<personagem>> _futurePersonagens;
  TextEditingController search = TextEditingController();
  PersonagemDao dao = PersonagemDao();
  ClasseApi api = ClasseApi();
  late Future<List<Classe>> futureclasses;


  @override
  void initState() {
    super.initState();
    _futurePersonagens = (Future.value([]));
    futureclasses = api.listarClasses();
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
      body: buildBody(),
    );
  }

  Widget buildBody(){
    return SafeArea(
      child: ListView(
        children: [
          FutureBuilder<List<personagem>>(
          future: _futurePersonagens,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final lista = snapshot.data ?? [];

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
          FutureBuilder<List<Classe>>(
            future: futureclasses,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final lista = snapshot.data ?? [];

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  final p = lista[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: const Color(0xFF2E5B8B),
                    child: Text(p.name)
                  );

                },
              );
            },
          ),
      ]
      ),
    );
  }
}