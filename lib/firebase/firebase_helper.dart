import 'package:appponto/models/funcionario_model.dart';
import 'package:appponto/models/model_registro.dart';
import 'package:appponto/sqlite/registro_dao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class FirebaseHelper {
  Firestore fb = Firestore.instance;

  FirebaseHelper();

  Future<bool> setPonto(matricula, Registro registro, int idSqlite) async {
    //appName - matricula - data - tipoRegistro
    registro.sync = 1;

    var path = fb
        .collection('app_ponto')
        .document(matricula)
        .collection(registro.data)
        .document(registro.registro);

    var doc = await path
        .get()
        .timeout(Duration(seconds: 5),onTimeout: ()=>null)
        .catchError((error) => print('erro = ${error.details}'));

    if (doc == null) return false;

    if (doc.exists) {
      print('doc existe e atualido sqlite');

      //alterar registro para sync 1 no sqlite
      RegistroDAO().update(registro, idSqlite);

      return true;
    } else {
      await path.setData(registro.toMap());

      if ((await path.get()).exists) {
        //ponto registrado no firebase
        //alterar registro para sync 1 no sqlite
        RegistroDAO().update(registro, idSqlite);

        print('sqlite atualizado e salvo no firebase');

        return true;
      } else {
        print('doc não criado no firebase');
        return false;
      }
    }
  }

  Future<List<Funcionario>> getFuncionarios() async {
    var path = fb.collection('app_ponto');

    var funcionarios = await path.getDocuments();

    return funcionarios.documents
        .map((snapshot) => Funcionario.fromMap(snapshot.data))
        .toList();
  }
}
