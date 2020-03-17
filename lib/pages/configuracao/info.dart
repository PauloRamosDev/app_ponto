import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/funcionario_model.dart';

class Infomacoes extends StatelessWidget {
  final List<Funcionario> listFun;

  Infomacoes(this.listFun);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Funcionários'),
      ),
      body: Column(
        children: <Widget>[
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(children: [
                Text(
                  'Matrícula',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'Nome',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ])
            ],
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: listFun.length,
              itemBuilder: (context, index) {
                return Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      Text(
                        listFun[index].matricula,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        listFun[index].nome,
                        textAlign: TextAlign.center,
                      ),
                    ])
                  ],
                );
              }),
        ],
      ),
    );
  }
}
