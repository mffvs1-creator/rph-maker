import 'package:rpgmaker/persona5/ficha_model.dart';
import 'package:sqflite/sqflite.dart';

import 'db_helperficha.dart';


class FichaDao {
  Future<List<FichasP>> listarFichas() async {
    Database db = await DBHelperFicha().initDB();

    var result = await db.rawQuery('SELECT * FROM FICHA ORDER BY id DESC');

    return result.map((row) => FichasP.fromMap(row)).toList();
  }

  Future<int> inserirFicha(FichasP ficha) async {
    Database db = await DBHelperFicha().initDB();

    return db.insert(
      'FICHA',
      ficha.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> atualizarFicha(FichasP ficha) async {
    if (ficha.id == null) {
      throw ArgumentError('Não é possível atualizar uma ficha sem id.');
    }

    Database db = await DBHelperFicha().initDB();

    return db.update(
      'FICHA',
      ficha.toMap(),
      where: 'id = ?',
      whereArgs: [ficha.id],
    );
  }

  Future<int> deletarFicha(int id) async {
    Database db = await DBHelperFicha().initDB();

    return db.delete('FICHA', where: 'id = ?', whereArgs: [id]);
  }
}
