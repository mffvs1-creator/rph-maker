import 'package:rpgmaker/persona5/personagem_model.dart';
import 'package:sqflite/sqflite.dart';

import 'db_helperficha.dart';

class fichadao {
  Future<List<personagem>> mostrarFicha() async {
    Database db = await DBHelperFicha().initDB();

    var result = await db.rawQuery('SELECT * FROM FICHA');

    List<personagem> lista = [];
    for (var json in result){
      
      personagem ficha = personagem.fromJson(json);
      lista.add(ficha);
    }

    return lista;
  }
}