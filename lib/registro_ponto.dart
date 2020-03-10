import 'dart:io';

import 'package:appponto/bloc_check_point.dart';
import 'package:appponto/firebase/firebase_helper.dart';
import 'package:appponto/nav.dart';
import 'package:appponto/relogio.dart';
import 'package:appponto/sqlite/registro_dao.dart';
import 'package:appponto/utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'models/model_registro.dart';

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
    getGps().then((position) {
      print("LATITUDE: " + position.latitude.toString());
      print("LONGITUDE: " + position.longitude.toString());

      latitude = position.latitude;
      longitude = position.longitude;

      setState(() {
        local =
            'LATITUDE: ${position.latitude.toString()} / LONGITUDE: ${position.longitude.toString()}';
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
                onPressed: () async {
                  var file = await getImage();

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

                  int idRegistro = await RegistroDAO().insert(registro);

                  var operacao = await FirebaseHelper()
                      .setPonto(widget.matricula, registro, idRegistro);

                  print('Operacao firebase = $operacao');

                  pop(context, tipo: idRegistro);
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

  Future<Position> getGps() async {
    return await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<File> getImage() async {
    return await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 1024, maxHeight: 1024);
  }
}
