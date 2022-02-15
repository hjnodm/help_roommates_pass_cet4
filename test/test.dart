import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class SqliteHelper{
  final sqlFileName='mydb.sql';
  final String table = 'user';

  static Database _db;

  Future<Database> get dbd async {
    if(_db==null){
      _db = await open();
    }
    return _db;
  }

  Database db;

  open() async {
    // String path;
    // path = "${await getDatabasesPath()}/$sqlFileName";
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    var dbPath = await getDatabasesPath();
    String path = join(documentsDirectory.path, sqlFileName);
    if(db==null){
      db = await openDatabase(path,version: 1,onCreate: (db,ver)async{
        await db.execute('''
          Create Table user(
            id text,
            name text,
            account text,
            password text,
            gender text,
            birthday text,
            gameTotal integer,
            gameWin integer,
            gameFailure integer,
            gameMoney integer
          );
        ''');
      });
    }
  }

  insert(Map<String,dynamic>m)async {
    var client = await dbd;
//    print(m.runtimeType);
    await client.insert(table, m);
  }
  findAll()async{
    var client = await dbd;
    await client.query(table);
  }
  delete(id)async{
    return await db.delete(table,where: id=id);
  }
}
