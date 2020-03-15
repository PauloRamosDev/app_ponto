import 'package:appponto/models/model_registro.dart';
import 'package:appponto/sqlite/sql_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class RegistroDAO {
  Future<Database> get db => SqliteHelper.getInstance().db;

  Future<int> insert(Registro registro) async {
    var dbClient = await db;
    var id = await dbClient.insert(
        SqliteHelper.tableRegistros, registro.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<int> update(Registro registro, int idSqlite) async {
    var dbClient = await db;
    var id = await dbClient.update(
        SqliteHelper.tableRegistros, registro.toMap(),
        where: 'id = $idSqlite', conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<Registro> findById(int id) async {
    var dbClient = await db;
    final list = await dbClient.rawQuery(
        'select * from ${SqliteHelper.tableRegistros} where id = ?', [id]);

    if (list.length > 0) {
      return new Registro.fromMap(list.first);
    }

    return null;
  }

  Future<List<Registro>> findByDayAndMatricula(
      String data, String matricula) async {
    var dbClient = await db;
    final list = await dbClient.rawQuery(
        'select * from ${SqliteHelper.tableRegistros} where data = ? AND matricula = ?',
        [data, matricula]);

    if (list.length > 0) {
      return list.map((e) => Registro.fromMap(e)).toList();
    }

    return null;
  }

  Future<List<Registro>> findAll() async {
    final dbClient = await db;

    final list =
        await dbClient.rawQuery('select * from ${SqliteHelper.tableRegistros}');

    final funcionarios =
        list.map<Registro>((json) => Registro.fromMap(json)).toList();

    return funcionarios;
  }

  Future deleteAll() async {
    var dbClient = await db;

    return await dbClient
        .rawQuery('DELETE FROM ${SqliteHelper.tableRegistros}');
  }

  Future<int> count() async {
    final dbClient = await db;

    final list = await dbClient
        .rawQuery('select count(*) from ${SqliteHelper.tableRegistros}');
    return Sqflite.firstIntValue(list);
  }

  Future<List<Registro>> registrosNoSync() async {
    var dbClient = await db;
    final list = await dbClient.rawQuery(
        'select * from ${SqliteHelper.tableRegistros} where sync = 0');

    if (list.length > 0) {
      return list.map((e) => Registro.fromMap(e)).toList();
    }

    return null;
  }  Future<bool> existNoSync() async {
    var dbClient = await db;
    final list = await dbClient.rawQuery(
        'select * from ${SqliteHelper.tableRegistros} where sync = 0');

    if (list.length > 0) {
      return true;
    }

    return false;
  }
}
