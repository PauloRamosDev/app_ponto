import 'package:appponto/firebase/firebase_helper.dart';
import 'package:appponto/sqlite/funcionario_dao.dart';
import 'package:appponto/sqlite/registro_dao.dart';
import 'package:flutter/material.dart';

class BlocHome {
  TextEditingController matricula = TextEditingController();
  TextEditingController senha = TextEditingController();

  Future<bool> validar() async {
    return (await FuncionarioDAO().findByMatricula(matricula.text)) != null;
  }

  syncAll() {
    RegistroDAO().registrosNoSync().then((noSync) {
      print('no sync = ${noSync?.length}');

      if (noSync != null && noSync.length > 0) FirebaseHelper().sync(noSync);
    });
  }
}
