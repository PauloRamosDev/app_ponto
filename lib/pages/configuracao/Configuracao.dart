import 'package:appponto/pages/configuracao/conf_empresa.dart';
import 'package:appponto/pages/configuracao/info.dart';
import 'package:flutter/material.dart';

import '../../nav.dart';
import '../../sqlite/funcionario_dao.dart';

class PageConfiguracao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: ListTile(
              onTap: () => push(context, ConfiguracaoEmpresa()),
              title: Text('Configurar Dados'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Informações'),
              onTap: () async {
                push(context, Infomacoes((await FuncionarioDAO().findAll())));
              },
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Instruções de uso'),
              onTap: () async {
                push(context, null);
              },
            ),
          ),
        ],
      ),
    );
  }
}
