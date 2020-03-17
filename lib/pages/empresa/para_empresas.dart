import 'package:appponto/pages/empresa/cadastro_funcionario.dart';
import 'package:appponto/pages/empresa/gestao_funcionarios.dart';
import 'package:flutter/material.dart';

import '../../nav.dart';

class HomeEmpresas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Para Empresas'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Card(
                  child: ListTile(
                    onTap: () => push(context, GestaoFuncionarios()),
                    title: Text('Getão de Funcionarios'),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Cadastrar'),
                    onTap: () async {
                      push(context, CadastroFuncionario());
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Extrações'),
                    onTap: () async {
                      push(context, null);
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Termos e condições de uso'),
                    onTap: () async {
                      push(context, null);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
