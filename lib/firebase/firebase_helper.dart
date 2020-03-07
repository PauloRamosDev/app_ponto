import 'package:appponto/models/funcionario_model.dart';
import 'package:appponto/models/model_registro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  Firestore fb = Firestore.instance;

  FirebaseHelper();

  setPonto(matricula, Registro registro) async {
    //appName - matricula - data - tipoRegistro

    var path = fb
        .collection('app_ponto')
        .document(matricula)
        .collection(registro.data)
        .document(registro.registro);

    var doc = await path.get();

    if (doc.exists) {
      print('doc existe');
    } else {
      path.setData(registro.toMap());

      print('doc nao existe');
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
