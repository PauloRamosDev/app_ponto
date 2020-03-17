import 'package:appponto/pages/configuracao/Configuracao.dart';
import 'package:appponto/pages/empresa/para_empresas.dart';
import 'package:appponto/pages/home/home_bloc.dart';
import 'package:appponto/preferences.dart';
import 'package:appponto/sqlite/registro_dao.dart';
import 'package:appponto/utils.dart';
import 'package:badges/badges.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../nav.dart';
import '../checkpoints/check_point.dart';

class HomePage extends StatefulWidget {
  final prefs = BlocProvider.getBloc<Prefs>();

  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BlocHome bloc = BlocHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('App Ponto Fácil'),
        actions: <Widget>[
          Consumer<Prefs>(builder: (context, prefs) {
            print('chamando o consumer PREFS');
            return upload(prefs.getNoSync() > 0);
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            logo(),
            Text(widget.prefs.getEmpresa().nome ?? ''), //nome da empresa
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
                    ),
                  ],
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                push(context, PageConfiguracao());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.settings),
                  Text(' Confirgurações')
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                push(context, HomeEmpresas());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.business_center),
                  Text(' Para empresas')
                ],
              ),
            ),
            //nome da empresa
          ],
        ),
      ),
    );
  }

  responsiveMargin() {
    var larg = MediaQuery.of(context).size.width;

    if (larg > 400) {
      return EdgeInsets.only(left: 80, right: 80, bottom: 80, top: 16);
    } else {
      return EdgeInsets.all(16);
    }
  }

  Widget upload(bool show) {
    return Badge(
      showBadge: show,
      badgeContent: Text(widget.prefs.getNoSync().toString()),
      badgeColor: Theme.of(context).accentColor,
      child: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
//            bloc.syncAll(widget.prefs.getEmpresa()).then((value) {
//              widget.prefs.setNoSync(value);
//            });
            bloc.syncAll(widget.prefs.getEmpresa().id);
          }),
      animationType: BadgeAnimationType.slide,
      position: BadgePosition.topRight(top: -4, right: 1),
    );
  }

  Widget logo() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Center(
        child: Image.network(
          widget.prefs.getEmpresa()?.logo,
          height: 100,
        ),
      ),
    );
  }
}
