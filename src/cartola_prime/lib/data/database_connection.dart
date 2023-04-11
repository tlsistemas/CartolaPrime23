import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  DatabaseConnection._privateConstructor();
  static final DatabaseConnection _db =
      DatabaseConnection._privateConstructor();
  // only have a single app-wide reference to the database

  factory DatabaseConnection() {
    return _db;
  }
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database!;
    return setDatabase();
    // lazily instantiate the db the first time it is accessed
  }

  Future<Database> setDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'cartola_prime.db');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<Database> initDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'cartola_prime.db');
    var database = await openDatabase(path, version: 1);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String sqlScout =
        "CREATE TABLE time_logado (id INTEGER PRIMARY KEY, time_id INT, assinante INT, nome_cartola TEXT, globo_id TEXT, nome TEXT, url_escudo_png TEXT, url_camisa_png TEXT, slug TEXT, clube_id INT, temporada_inicial INT, UNIQUE(time_id));";
    await database.execute(sqlScout);
  }

  Future<void> deleteDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'cartola_prime.db');
    databaseFactory.deleteDatabase(path);
  }

  Future<bool> ifDatabaseExist() async {
    Database? db = await _db.database;
    var res = await db!.rawQuery("select * from time_logado");
    return res.isNotEmpty ? true : false;
  }
}
