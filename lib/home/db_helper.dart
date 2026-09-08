import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {

  initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'rpg-2.db';

    String dbPath = join(path, dbName);
    Database db = await openDatabase(dbPath, version: 1, onCreate: onCreate);

  return db;
  }

  Future<void> onCreate(Database db, int version) async {
    String sql = '''
        CREATE TABLE OPCOES (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          NAME TEXT
          
        );            
    ''';

    db.execute(sql);

    sql = '''INSERT INTO OPCOES (NAME) VALUES
        ('Mapas'),
        ('Fichas'),
        ('Dados'),
        ('Personagens'),
        ('Creditos');
    ''';
    db.execute(sql);

    sql = '''
    CREATE TABLE USER (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    USERNAME TEXT,
    PASSWORD TEXT );
   ''';
    db.execute(sql);


    sql = "INSERT INTO USER (username, password) VALUES ('ademar@gmail.com', '654321');";
    await db.execute(sql);

  }
}