import 'package:appponto/firebase/firebase_helper.dart';
import 'package:appponto/nav.dart';
import 'package:appponto/pages/checkpoints/bloc_check_point.dart';
import 'package:appponto/pages/home/home.dart';
import 'package:appponto/relogio.dart';
import 'package:appponto/sqlite/registro_dao.dart';
import 'package:appponto/utils.dart';
import 'package:flutter/material.dart';

import '../../models/model_registro.dart';

class RegistroPage extends StatefulWidget {
  final marcacao;
  final matricula;
  final BlocCheckPoint bloc;

  RegistroPage(
      {@required this.marcacao, @required this.matricula, @required this.bloc});

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  var local = 'Desconhecido';
  var latitude;
  var longitude;

  @override
  void initState() {
    Utils.getGps().then((position) {
      latitude = position.latitude;
      longitude = position.longitude;

      setState(() {
        local = position.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registro'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(widget.marcacao),
              RaisedButton(
                onPressed: () {
                  _registarPonto();
                },
                color: Colors.greenAccent,
                child: Text(
                  'REGISTRAR',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Relogio(),
              Text('Local : $local')
            ],
          ),
        ));
  }

  void _registarPonto() async {
    var file = await Utils.getImage();

    if (file != null) {
      var registro = Registro(
          longitude.toString(),
          latitude.toString(),
          widget.marcacao,
          file.path,
          Utils.getHora(),
          Utils.getData(),
          0,
          widget.matricula);

      print(registro.toMap().toString());

      int idSqlite = await RegistroDAO().insert(registro);

      var operacao = await FirebaseHelper('minhaEmpresa').setPonto(registro, idSqlite);

      print('Operacao firebase = $operacao');

      resetAndOpenPage(context, HomePage());
    }
  }
}
