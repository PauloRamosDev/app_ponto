import 'package:appponto/models/funcionario_model.dart';
import 'package:appponto/sqlite/sql_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class FuncionarioDAO {
  Future<Database> get db => SqliteHelper.getInstance().db;

  Future<int> insert(Funcionario funcionario) async {
    var dbClient = await db;
    var id = await dbClient.insert(SqliteHelper.tableFuncionario, funcionario.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<Funcionario> findByMatricula(String matricula) async {
    var dbClient = await db;
    final list = await dbClient.rawQuery(
        'SELECT * FROM ${SqliteHelper.tableFuncionario} WHERE matricula = ?',
        [matricula]);

    if (list.length > 0) {
      return new Funcionario.fromMap(list.first);
    }

    return null;
  }

  Future<List<Funcionario>> findAll() async {
    final dbClient = await db;

    final list =
        await dbClient.rawQuery('SELECT * FROM ${SqliteHelper.tableFuncionario}');

    final funcionarios =
        list.map<Funcionario>((json) => Funcionario.fromMap(json)).toList();

    return funcionarios;
  }

  Future deleteAll() async {
    var dbClient = await db;

    return await dbClient
        .rawQuery('DELETE FROM ${SqliteHelper.tableFuncionario}');
  }

  Future<int> count() async {
    final dbClient = await db;

    final list = await dbClient
        .rawQuery('SELECT count(*) FROM ${SqliteHelper.tableFuncionario}');
    return Sqflite.firstIntValue(list);
  }
}
