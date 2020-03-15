import 'package:appponto/firebase/firebase_helper.dart';
import 'package:appponto/sqlite/funcionario_dao.dart';
import 'package:appponto/sqlite/registro_dao.dart';
import 'package:flutter/material.dart';

class BlocHome {
  TextEditingController matricula = TextEditingController();
  TextEditingController senha = TextEditingController();

  Future<bool> validar() async {
    var func = await FuncionarioDAO().findByMatricula(matricula.text);

    return func?.senha == senha.text && func?.matricula == matricula.text&&senha.text.length>3&&matricula.text.length>6;
  }

  Future<int> syncAll(String empresa) async {
    var noSync = await RegistroDAO().registrosNoSync();

    print('no sync = ${noSync?.length}');

    if (noSync != null && noSync.length > 0) {
      return await FirebaseHelper(empresa).sync(noSync);
    }
    return 0;
  }
}
