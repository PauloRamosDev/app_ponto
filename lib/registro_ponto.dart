import 'package:appponto/relogio.dart';
import 'package:flutter/material.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
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
              Text('INICIO DA JORNADA'),
              RaisedButton(
                onPressed: () {},
                color: Colors.greenAccent,
                child: Text(
                  'REGISTRAR',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Relogio(),
            ],
          ),
        ));
  }
}
