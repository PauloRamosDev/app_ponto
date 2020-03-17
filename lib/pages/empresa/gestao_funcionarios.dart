import 'package:appponto/models/funcionario_model.dart';
import 'package:appponto/sqlite/funcionario_dao.dart';
import 'package:flutter/material.dart';

class GestaoFuncionarios extends StatefulWidget {
  @override
  _GestaoFuncionariosState createState() => _GestaoFuncionariosState();
}

class _GestaoFuncionariosState extends State<GestaoFuncionarios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Situação de Atividade'),),
      body: FutureBuilder<List<Funcionario>>(
          future: FuncionarioDAO().findAll(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0,8,16,8),
                        child: Text(
                          'Funcionário'
                        ,style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0,8,16,8),
                        child: Text('Situação',style: TextStyle(fontSize: 20),),
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data[index].nome.toUpperCase()),
                            trailing: Switch(
                                value: snapshot.data[index].ativo == 1
                                    ? true
                                    : false,
                                onChanged: (value) {}),
                          );
                        }),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Erro'),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
