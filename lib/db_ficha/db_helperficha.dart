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
    // Table for fichas the user creates in the app. The example fichas
    // shown on the home screen come from FichaApiFake, not this table —
    // this only stores fichas the player actually saves.
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

    sql = "INSERT INTO USER (username, password) VALUES ('Hangolanu', '40028922');";
    await db.execute(sql);
  }
}
