import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {

  initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'rpg.db';

    String dbPath = join(path, dbName);
    openDatabase(dbPath, version: 1, onCreate: onCreate);


  }

  FutureOr<void> onCreate(Database db, int version) {
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
    NAME TEXT,
    PASSWORD TEXT );
   ''';
    db.execute(sql);



  }
}