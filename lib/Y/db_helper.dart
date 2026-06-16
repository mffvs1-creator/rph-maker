

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
        CREATE TABLE RPG (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          NAME TEXT,
          END TEXT,
          
        );            
    ''';

    db.execute(sql);

    sql = "INSERT INTO RPG (NAME, END) VALUES ('JOSE', 'AV DAKJDALS');";
    db.execute(sql);


  }
}