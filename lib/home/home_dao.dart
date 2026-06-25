import 'package:rpgmaker/home/opcoes.dart';
import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';

class OpcoesDao {
  Future<List<Opcoes>> listOpcoes () async {
    Database db = await DBHelper().initDB();
    String sql = 'SELECT * FROM OPCOES;';
    var result = await db.rawQuery(sql);
    List<Opcoes> lista = [];

    for(var json in result){
      // json = {id: 1, name: 'fi8cvha'}
      Opcoes o = Opcoes.fromJson(json);
      lista.add(o);
    }
    return lista;

  }
}