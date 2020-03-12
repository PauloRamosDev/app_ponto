import 'package:appponto/firebase/firebase_helper.dart';
import 'package:appponto/pages/home/home_bloc.dart';
import 'package:appponto/sqlite/funcionario_dao.dart';
import 'package:appponto/sqlite/registro_dao.dart';
import 'package:appponto/utils.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../nav.dart';
import '../checkpoints/check_point.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BlocHome bloc = BlocHome();
  var noSync = 0;

  @override
  void initState() {
    //buscar funcionarios no firebase e add no sqlite

    FirebaseHelper('minhaEmpresa').getFuncionarios().then((value) {
      value.forEach((element) {
        FuncionarioDAO().insert(element);
      });
    });

//sync registro não sync
//    bloc.syncAll();

    RegistroDAO().registrosNoSync().then((value) {
      noSync = value != null ? value.length : 0;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('App Ponto Fácil'),
        actions: <Widget>[
          upload(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              margin: responsiveMargin(),
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
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
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
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
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
                                        color: Colors.yellow.shade600,
                                      ),
                                      Text(' Alerta!')
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        child: Text(
                                      'Dados invalidos.\n'
                                      'Verifique os dados e tente novamente!',
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
      ),
    );
  }

  upload() {
    return Visibility(
      child: Badge(
        badgeContent: Text(noSync.toString()),
        badgeColor: Theme.of(context).accentColor,
        child: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              bloc.syncAll().then((value) {
                noSync = value;
                setState(() {});
              });
            }),
        animationType: BadgeAnimationType.slide,
        position: BadgePosition.topRight(top: 0, right: 8),
      ),
      visible: noSync > 0,
    );
  }

  responsiveMargin() {
    var larg = MediaQuery.of(context).size.width;

    if (larg > 400) {
      return EdgeInsets.only(left: 100, right: 100, bottom: 100, top: 16);
    } else {
      return EdgeInsets.all(16);
    }
  }
}
