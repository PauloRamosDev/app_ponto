import 'package:appponto/sqlite/funcionario_dao.dart';
import 'package:flutter/material.dart';

class BlocHome {
  TextEditingController matricula = TextEditingController();
  TextEditingController senha = TextEditingController();

  Future<bool> validar() async {
    return (await FuncionarioDAO().findByMatricula(matricula.text)) != null;
  }
}
