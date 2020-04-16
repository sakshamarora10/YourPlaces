import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> getDB() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT,image TEXT,latitude REAL,longitude REAL,address TEXT)');
    },version: 1);
  }

  static Future<void> insertData(String table, Map<String, Object> data) async {
    final sqlDatabase = await DBHelper.getDB();
    await sqlDatabase.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String,dynamic>>> getData(String table) async {
    final sqlDatabase=await DBHelper.getDB();
    final tableData= await sqlDatabase.query(table);
    return tableData;
  }

  static Future<void> deleteData(String table,String id) async {

    final sqlDatabase=await DBHelper.getDB();
    await sqlDatabase.delete(table,where: 'id = ?',whereArgs: [id]);
  }
}
