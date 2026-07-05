import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DBHelperpersonagens {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'rphmaker.db';
    
    String dbPath = path + dbName;

    Database db = await openDatabase(dbPath, version: 1, onCreate: onCreateDB);

    return db;
  }

  Future<void> onCreateDB(Database db, int version) async {
    String sql = '''CREATE TABLE PERSONAGEM (
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
    );''';

    await db.execute(sql);

    sql = "INSERT INTO PERSONAGEM (nome, classe, pvAtual, pvMax, forca, agilidade, inteligencia, ca, imagem) VALUES ('Julio','Guerreiro',35,35,10,8,6,18,'https://i.pinimg.com/736x/eb/01/04/eb01044783b72a4140d5fa80ec28f104.jpg');";
    await db.execute(sql);
    
    sql = "INSERT INTO PERSONAGEM (nome, classe, pvAtual, pvMax, forca, agilidade, inteligencia, ca, imagem) VALUES ('Elara','Arqueira',22,22,10,8,6,18,'https://cdn.rafled.com/anime-icons/images/sN5EGhvu8EvZA35RXmT3tU8jQwOalzqK.jpg');";
    await db.execute(sql);

    sql = "INSERT INTO PERSONAGEM (nome, classe, pvAtual, pvMax, forca, agilidade, inteligencia, ca, imagem) VALUES ('Lysandra','Curandeira',10,10,10,8,6,18,'https://cdn.rafled.com/anime-icons/images/f2avsZPYjzdLGSjT1Jrp63aKhRT8yyCW.jpg');";
    await db.execute(sql);
  }
}
