import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBManager {

  String dbName = "visitMe.db";

  static final DBManager instance = DBManager._init();

  DBManager._init();

  Future<Database> get database async {
    final dbPath = await getDatabasesPath();
    // final path = "$dbPath/$dbName";
    final path = join(dbPath, dbName);

    return openDatabase(path, version: 1, onCreate: _onCreateTable);
  }

  Future<void> _onCreateTable(Database db, int version) async {
    String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    String textType = "TEXT";
    String doubleType = "DOUBLE";
    String intType = "INTEGER";

    final productTableSql = '''
    CREATE TABLE IF NOT EXISTS tbl_product(
      id $idType,
      name $textType,
      price $doubleType,
      quantity $intType
    )
  ''';
    await db.execute(productTableSql);

    final categoryTableSql = '''
    CREATE TABLE IF NOT EXISTS tbl_category(
      id $idType,
      name $textType
    )
  ''';
    await db.execute(categoryTableSql);
  }
}