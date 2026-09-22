import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperFicha {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'ficha.db';

    String dbPath = join(path, dbName);

    Database db = await openDatabase(dbPath, version: 1, onCreate: onCreateDB);

    return db;
  }

  Future<void> onCreateDB(Database db, int version) async {

    String sql = '''CREATE TABLE FICHA (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT,
      classe TEXT,
      pvAtual INTEGER,
      pvMax INTEGER,
      forca INTEGER,
      agilidade INTEGER,
      inteligencia INTEGER,
      ca INTEGER,
      imagem TEXT
    ); ''';

    await db.execute(sql);

    sql = '''CREATE TABLE USER (
      username TEXT PRIMARY KEY,
      password TEXT
    );''';

    await db.execute(sql);

    sql = "INSERT INTO USER (username, password) VALUES ('ademar@gmail.com', '654321');";
    await db.execute(sql);
  }
}
