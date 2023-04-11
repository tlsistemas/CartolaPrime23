import 'package:sqflite/sqflite.dart';

import 'database_connection.dart';

class DataBaseRepository {
  late DatabaseConnection _databaseConnection;

  DataBaseRepository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  Future<void> insert(String table, Map<String, dynamic> data) async {
    try {
      var connection = await database;
      await connection!.insert(
        table,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      var res = await connection.query(table);
    } catch (e) {
      print('DbException' + e.toString());
    }
  }

  Future<void> insertBatch(
      String table, List<Map<String, dynamic>> data) async {
    try {
      var connection = await database;
      var batch = connection!.batch();
      for (var element in data) {
        batch.insert(table, element,
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true);
    } catch (e) {
      print('DbException' + e.toString());
    }
  }

  Future<List<dynamic>?> insertBatchResponse(
      String table, List<Map<String, dynamic>> data) async {
    try {
      var connection = await database;
      var batch = connection!.batch();
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

  Future<void> insertSingle(String query) async {
    try {
      var connection = await database;
      await connection?.rawQuery(query);
    } catch (e) {
      print('erro-insertSingle' + e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getAll(String table) async {
    var connection = await database;
    var res = await connection!.query(table);
    return res;
  }

  Future<Map<String, dynamic>> getOne(String table, int id) async {
    var connection = await database;
    var res = await connection!.rawQuery("select * from $table where id=$id");
    return res.first;
  }

  Future<Map<String, dynamic>> getOneCampoIdOrderBy(
      String table, String campo, int id, String? order) async {
    var connection = await database;
    var res = await connection!
        .rawQuery("select * from $table where $campo=$id $order");
    return res.first;
  }

  Future<List<Map<String, dynamic>>> getByCampoIdOrderBy(
      String table, String campo, int id, String? order) async {
    var connection = await database;
    var res = await connection!
        .rawQuery("select * from $table where $campo=$id $order");
    return res;
  }

  Future<List<Map<String, dynamic>>> getByWhere(
    String table,
    String whereCondition,
  ) async {
    var connection = await database;
    var res = await connection!
        .rawQuery("select * from $table where $whereCondition");

    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRowsCustom(String query) async {
    var connection = await database;
    var res = await connection!.rawQuery(query);
    return res;
  }

  Future<int?> update(String table, Map<String, dynamic> data) async {
    try {
      var connection = await database;
      return await connection!
          .update(table, data, where: "id = ?", whereArgs: [data['id']]);
    } catch (e) {
      print('DbException' + e.toString());
      return null;
    }
  }

  Future<int?> delete(String table, String id) async {
    try {
      var connection = await database;
      var result =
          await connection!.delete(table, where: "id = ?", whereArgs: [id]);
      return result;
    } catch (e) {
      print('DbException' + e.toString());
      return null;
    }
  }
}
