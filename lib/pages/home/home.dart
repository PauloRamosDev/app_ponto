import 'package:appponto/pages/home/home_bloc.dart';
import 'package:appponto/sqlite/registro_dao.dart';
import 'package:appponto/utils.dart';
import 'package:flutter/material.dart';

import '../checkpoints/check_point.dart';
import '../../nav.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BlocHome bloc = BlocHome();

  @override
  void initState() {
    //todo: função para buscar funcionario e salvarlocalmente no sqlite


    RegistroDAO().registrosNoSync().then((noSync){
      noSync.forEach((r)=>print(r.toMap().toString()));
    });

    //    FirebaseHelper().getFuncionarios().then((funcionarios) {
//      funcionarios.forEach((funcionario) {
//        FuncionarioDAO().insert(funcionario);
//      });
//
//      print('TOTAL DE FUNCIONARIOS = ${funcionarios.length}');
//    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
//        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: FlutterLogo(
              size: 100,
              colors: Colors.purple,
            ),
          ),
          Text(''), //nome da empresa
          Card(
            margin: EdgeInsets.all(16),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'MATRICULA',
                    style: TextStyle(color: Colors.purple),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: bloc.matricula,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.numberWithOptions(),
                      maxLength: 7,
                    ),
                  ),
                  Text(
                    'SENHA',
                    style: TextStyle(color: Colors.purple),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: bloc.senha,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.numberWithOptions(),
                      maxLength: 4,
                      obscureText: true,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      if (await bloc.validar()) {
                        var listCheckPoint = await RegistroDAO()
                            .findByDayAndMatricula(
                                Utils.getData(), bloc.matricula.text);
                        push(
                            context,
                            CheckPointPage(
                                matricula: bloc.matricula.text,
                                listaCheckPoints: listCheckPoint ?? []));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.warning,
                                      color: Colors.yellow,
                                    ),
                                    Text(' Alerta!')
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      child: Text(
                                    'Dados invalidos.',
                                    textAlign: TextAlign.center,
                                  )),
                                ),
                                actions: <Widget>[
                                  ButtonBar(
                                    children: <Widget>[
                                      RaisedButton(
                                        onPressed: () {
                                          pop(context);
                                        },
                                        child: Text('OK'),
                                        color: Theme.of(context).primaryColor,
                                      )
                                    ],
                                  )
                                ],
                              );
                            });
                      }
                    },
                    color: Colors.greenAccent,
                    child: Text(
                      'ENTRAR',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
