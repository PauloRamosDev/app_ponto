import 'package:appponto/models/funcionario_model.dart';
import 'package:appponto/sqlite/sql_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class FuncionarioDAO {
  Future<Database> get db => SqliteHelper.getInstance().db;

  Future<int> insert(Funcionario funcionario) async {
    var dbClient = await db;
    var id = await dbClient.insert(SqliteHelper.tableName, funcionario.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<Funcionario> findByMatricula(String matricula) async {
    var dbClient = await db;
    final list = await dbClient.rawQuery(
        'select * from ${SqliteHelper.tableName} where matricula = ?',
        [matricula]);

    if (list.length > 0) {
      return new Funcionario.fromMap(list.first);
    }

    return null;
  }

  Future<List<Funcionario>> findAll() async {
    final dbClient = await db;

    final list =
        await dbClient.rawQuery('select * from ${SqliteHelper.tableName}');

    final funcionarios =
        list.map<Funcionario>((json) => Funcionario.fromMap(json)).toList();

    return funcionarios;
  }

  Future deleteAll() async {
    var dbClient = await db;

    await dbClient.rawQuery('DROP TABLE IF EXISTS ${SqliteHelper.tableName}');

    return await dbClient.rawQuery(
        'CREATE TABLE IF NOT EXISTS ${SqliteHelper.tableName}(id INTEGER PRIMARY KEY)');
  }

  Future<int> count() async {
    final dbClient = await db;

    final list = await dbClient
        .rawQuery('select count(*) from ${SqliteHelper.tableName}');
    return Sqflite.firstIntValue(list);
  }
}
