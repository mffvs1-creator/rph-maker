import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';

class RpgDao {

  listRPG () async {
    Database db = await DBHelper().initDB();
    String sql = 'SELECT * FROM RPG';

    var result = await db.rawQuery(sql);
    // [ {id: 1, name: 'joao', end: asdas},  {id: 2, name: 'maria', end: 'endreco'} ]

    for(var json in result){
      // json = {id: 1, name: 'joao', end: asdas}

    }

  }

}