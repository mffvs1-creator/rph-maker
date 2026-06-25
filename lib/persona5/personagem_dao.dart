import 'package:sqflite/sqflite.dart';
import 'db_helperpersonagens.dart';
import 'personagem_model.dart';

class PersonagemDao {
  Future<List<personagem>> listarPersonagens() async {
    Database db = await DBHelperpersonagens().initDB();

    final result = await db.rawQuery('SELECT * FROM PERSONAGEM');

    final List<personagem> lista = [];
    for (final json in result) {
      final p = personagem.fromJson(json as Map<String, dynamic>);
      lista.add(p);
    }
    return lista;
  }
}
