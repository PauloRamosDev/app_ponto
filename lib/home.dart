import 'package:appponto/check_point.dart';
import 'package:appponto/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          Text(''),
          Card(
            margin: EdgeInsets.all(16),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('MATRICULA',style: TextStyle(color: Colors.purple),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(textAlign: TextAlign.center,keyboardType: TextInputType.numberWithOptions(),maxLength: 7,),
                  ),
                  Text('SENHA',style: TextStyle(color: Colors.purple),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(textAlign: TextAlign.center,keyboardType: TextInputType.numberWithOptions(),maxLength: 4,obscureText: true,),
                  ),
                  RaisedButton(
                    onPressed: () {
                      push(context, CheckPointPage());
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
