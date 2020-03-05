import 'package:appponto/nav.dart';
import 'package:appponto/registro_ponto.dart';
import 'package:flutter/material.dart';

class CheckPointPage extends StatefulWidget {
  @override
  _CheckPointPageState createState() => _CheckPointPageState();
}

class _CheckPointPageState extends State<CheckPointPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ponto'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('INICIO DA JORNADA'),
              subtitle: Text('Aguardando'),
              trailing:
                  IconButton(icon: Icon(Icons.arrow_forward), onPressed: () {push(context, RegistroPage());}),
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('INICIO DA PAUSA'),
              subtitle: Text('Aguardando'),
              trailing:
                  IconButton(icon: Icon(Icons.arrow_forward), onPressed: () {}),
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('TERMINO DA PAUSA'),
              subtitle: Text('Aguardando'),
              trailing:
                  IconButton(icon: Icon(Icons.arrow_forward), onPressed: () {}),
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('TERMINO DE JORNADA'),
              subtitle: Text('Aguardando'),
              trailing:
                  IconButton(icon: Icon(Icons.arrow_forward), onPressed: () {}),
            ),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'TOTAL DA JORNADA',
                      style: TextStyle(color: Colors.purple),
                    ),
                    Text('6:00'),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'TOTAL DA PAUSA',
                      style: TextStyle(color: Colors.purple),
                    ),
                    Text('1:03'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
