import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../shared/utils/base_urls.dart';

class DBCartola with baseUrls {
  List<String> scriptList = [];
  Iterable<String> valueJson = [];

  DBCartola._privateConstructor();
  static final DBCartola _db = DBCartola._privateConstructor();

  factory DBCartola() {
    return _db;
  }
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database!;
    return _initDatabase();
  }

  static Future<Database?> _initDatabase() async {
    if (_database != null) return _database;
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, 'cartola_prime.db');
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: await _onCreate,
      );
      print('Db Criado: $_database');
      return _database;
    } catch (e) {
      print('DbException' + e.toString());
      return null;
    }
  }

  Future<void> deleteDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'cartola_prime.db');
    databaseFactory.deleteDatabase(path);
  }

  Future<Map<String, dynamic>> ifDatabaseExist() async {
    Database? db = await _db.database;
    var res = await db!.rawQuery("select * from vwforms_cadastro");
    return res.first;
  }

  Future<void> insert(String table, Map<String, dynamic> data) async {
    try {
      Database? db = await _db.database;
      await db!
          .insert(
            table,
            data,
            conflictAlgorithm: ConflictAlgorithm.replace,
          )
          .then(
            (value) => print('Db Inserted'),
          );
    } catch (e) {
      print('DbException' + e.toString());
    }
  }

  Future<int?> insertInt(String table, Map<String, dynamic> data) async {
    try {
      Database? db = await _db.database;
      return await db!.insert(
        table,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('DbException' + e.toString());
      return null;
    }
  }

  Future<void> insertBatch(
      String table, List<Map<String, dynamic>> data) async {
    try {
      Database? db = await _db.database;
      var batch = db!.batch();
      for (var element in data) {
        batch.insert(table, element,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
      print('Dados Inseridos no DB: $table');
    } catch (e) {
      print('DbException' + e.toString());
    }
  }

  Future<List<dynamic>?> insertBatchResponse(
      String table, List<Map<String, dynamic>> data) async {
    try {
      Database? db = await _db.database;
      var batch = db!.batch();
      for (var element in data) {
        batch.insert(table, element,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      var result = await batch.commit(noResult: false);
      if (result.isNotEmpty) {
        return result.toList();
      } else {
        return null;
      }
    } catch (e) {
      print('DbException' + e.toString());
      return null;
    }
  }

  static Future<void> insertSingle(String query) async {
    try {
      Database? db = await _db.database;
      await db?.rawQuery(query);
    } catch (e) {
      print('erro-insertSingle' + e.toString());
    }
  }

  // SQL code to create the database table
  static Future _onCreate(Database db, int version) async {
    print("oncreate_DB");
  }

  Future<List<Map<String, dynamic>>> getAll(String table) async {
    Database? db = await _db.database;
    var res = await db!.query(table);
    return res;
  }

  Future<Map<String, dynamic>> getOne(String table, int id) async {
    Database? db = await _db.database;
    var res = await db!.rawQuery("select * from $table where id=$id");
    return res.first;
  }

  Future<Map<String, dynamic>> getOneByCampoId(
      String table, String campo, int id, String? order) async {
    Database? db = await _db.database;
    var res =
        await db!.rawQuery("select * from $table where $campo=$id $order");
    return res.first;
  }

  Future<List<Map<String, dynamic>>> getByCampoAndId(
      String table, String campo, int id, String? order) async {
    Database? db = await _db.database;
    var res =
        await db!.rawQuery("select * from $table where $campo=$id $order");
    return res;
  }

  Future<List<Map<String, dynamic>>> getBy2Campos(
    String table,
    String campo1,
    String campo2,
    int id1,
    int id2,
  ) async {
    Database? db = await _db.database;
    var res = await db!.rawQuery(
        "select * from $table where $campo1=? and $campo2=?", [id1, id2]);

    return res;
  }

  Future<List<Map<String, dynamic>>> getByNotCampo(
    String table,
    String campo1,
    int id1,
  ) async {
    Database? db = await _db.database;
    var res =
        await db!.rawQuery("select * from $table where $campo1!=?", [id1]);

    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRowsCustom(String query) async {
    Database? db = await _db.database;
    var res = await db!.rawQuery(query);
    return res;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await _db.database;
    return await db!.query('vwusuarios');
  }

  Future<int?> update(String table, Map<String, dynamic> data) async {
    try {
      Database? db = await _db.database;
      return await db!
          .update(table, data, where: "id = ?", whereArgs: [data['id']]);
    } catch (e) {
      print('DbException' + e.toString());
      return null;
    }
  }

  Future<int?> delete(String table, String id) async {
    try {
      Database? db = await _db.database;
      var result = await db!.delete(table, where: "id = ?", whereArgs: [id]);
      return result;
    } catch (e) {
      print('DbException' + e.toString());
      return null;
    }
  }
}
