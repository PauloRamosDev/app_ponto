import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class SqliteHelper {
  static final SqliteHelper _instance = SqliteHelper.getInstance();

  static const tableFuncionario = 'funcionarios';
  static const tableRegistros = 'Registros';

  SqliteHelper.getInstance();

  factory SqliteHelper() => _instance;

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();

    return _db;
  }

  Future _initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'app_ponto.db');

    var db = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $tableFuncionario('
        'id INTEGER PRIMARY KEY,'
        'nome TEXT NOT NULL,'
        'senha TEXT NOT NULL,'
        'matricula TEXT NOT NULL UNIQUE'
        ')');

    await db.execute('CREATE TABLE $tableRegistros('
        'id INTEGER PRIMARY KEY, '
        'longitude TEXT,'
        'latitude TEXT,'
        'registro TEXT,'
        'pathFoto TEXT,'
        'horario TEXT,'
        'data TEXT,'
        'sync INTEGER,'
        'matricula TEXT'
        ')');
  }

  Future<FutureOr<void>> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion == 1 && newVersion == 2) {
//      await db.execute("alter table carro add column NOVA TEXT");
    }
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  Future<void> delete() async {
    var dbClient = await db;
    await dbClient.delete('$tableFuncionario');
  }

  void alterTable(nome, tipo) async {
    var bd = await db;

    bd.execute('ALTER TABLE $tableFuncionario ADD $nome VARCHAR').catchError((error) {
      print(error.toString());
    });
  }
}
