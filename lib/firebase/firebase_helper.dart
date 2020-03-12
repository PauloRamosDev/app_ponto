import 'package:appponto/models/funcionario_model.dart';
import 'package:appponto/models/model_registro.dart';
import 'package:appponto/sqlite/registro_dao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {

  Firestore fb = Firestore.instance;
  final nomeEmpresa;

  FirebaseHelper(this.nomeEmpresa);

  getEmpresa() async {
    //appName - empresa
    var path = fb.document('app_ponto/$nomeEmpresa');

    return await path.get();
  }

  Future<List<Funcionario>> getFuncionarios() async {
    //appName - empresa - funcionarios

    var path = fb.collection('app_ponto/$nomeEmpresa/funcionarios');

    var funcionarios = await path.getDocuments();

    return funcionarios.documents
        .map((snapshot) => Funcionario.fromMap(snapshot.data))
        .toList();
  }

  Future<bool> setPonto(Registro registro, int idSqlite) async {
    //appName - empresa -  matricula - matricula - data - tipoRegistro
    registro.sync = 1;
    registro.id = idSqlite;

    var path = fb
        .collection('app_ponto')
        .document(nomeEmpresa)
        .collection('funcionarios')
        .document(registro.matricula)
        .collection(registro.data)
        .document(registro.registro);

    var doc = await path
        .get()
        .timeout(Duration(seconds: 3), onTimeout: () => null)
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
        RegistroDAO().update(registro, idSqlite);

        print('sqlite atualizado e salvo no firebase');

        return true;
      } else {
        print('doc não criado no firebase');
        return false;
      }
    }
  }

  Future<int> sync(List<Registro> listaRegistros) async {
    var erros = 0;

    for (var i = 0; i < listaRegistros.length; ++i) {
      bool result = await setPonto(listaRegistros[i], listaRegistros[i].id);
      print(result);

      if (!result) {
        erros++;
      }
    }

    return erros;
  }

}
