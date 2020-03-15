import 'package:appponto/pages/configuracao/conf_empresa.dart';
import 'package:flutter/material.dart';

import '../../nav.dart';

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
              onTap: ()=>push(context, ConfiguracaoEmpresa()),
              title: Text('Configurar Dados'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Informações'),
            ),
          ),
        ],
      ),
    );
  }
}
