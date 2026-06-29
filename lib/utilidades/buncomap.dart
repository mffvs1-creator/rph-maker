import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BancoMap {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'locais_missoes.db';
    String dbPath = join(path, dbName);

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE LOCAIS (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            imagem TEXT,
            marcado INTEGER
          )
        ''');

        await db.insert('LOCAIS', {
          'nome': 'Floresta das Fadas',
          'imagem': 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%2Fid%2FOIP.h2bP6MInkwUe2reekgKyhAHaEo%3Fpid%3DApi&f=1&ipt=3b4b74f9644ec077f43072bf21429090501c9b371ad23ca5272b7908a941cbda&ipo=images',
          'marcado': 0
        });

        await db.insert('LOCAIS', {
          'nome': 'Monte Fenrir',
          'imagem': 'https://i.pinimg.com/originals/0a/8a/83/0a8a83e22587bbe6ec62aab5034f406d.jpg',
          'marcado': 0
        });

        await db.insert('LOCAIS', {
          'nome': 'Deserto solar',
          'imagem': 'https://thumbs.dreamstime.com/b/sol-de-ard%C3%AAncia-atrav%C3%A9s-do-deserto-3278743.jpg',
          'marcado': 0
        });

        await db.insert('LOCAIS', {
          'nome': 'Ilhas dos Monstro',
          'imagem': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsiavzQbBMa7XN4Bq4LXLCV_ZXD0XrzFnq9g&s',
          'marcado': 0
        });
      },
    );
  }

  Future<List<Map<String, dynamic>>> listarLocais() async {
    Database db = await initDB();
    return await db.query('LOCAIS');
  }

  Future<void> atualizarStatus(int id, int novoStatus) async {
    Database db = await initDB();
    await db.update(
      'LOCAIS',
      {'marcado': novoStatus},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
