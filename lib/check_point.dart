import 'package:appponto/bloc_check_point.dart';
import 'package:appponto/models/model_registro.dart';
import 'package:appponto/nav.dart';
import 'package:appponto/registro_ponto.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class CheckPointPage extends StatefulWidget {
  final matricula;
  final List<Registro>listaCheckPoints;

  CheckPointPage({@required this.matricula, @required this.listaCheckPoints});

  @override
  _CheckPointPageState createState() => _CheckPointPageState();
}

class _CheckPointPageState extends State<CheckPointPage> {
  BlocCheckPoint bloc = BlocCheckPoint();

  @override
  void initState() {
    print(widget.listaCheckPoints?.length??0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ponto'),
        actions: <Widget>[
          Badge(
            badgeContent: Text(''),
            badgeColor: Theme.of(context).accentColor,
            child: IconButton(icon: Icon(Icons.refresh), onPressed: () {}),
            animationType: BadgeAnimationType.slide,
            position: BadgePosition.topRight(top: 0, right: 8),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text(Registro.inicio),
              subtitle: Text(bloc.fistRegister == true ? 'OK' : 'Aguardando'),
              trailing: bloc.fistRegister == false
                  ? IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        push(
                            context,
                            RegistroPage(
                              bloc: bloc,
                              marcacao: Registro.inicio,
                              matricula: widget.matricula,
                            ));
                      })
                  : null,
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text(Registro.inicioPausa),
              subtitle: Text('Aguardando'),
              trailing: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    push(
                        context,
                        RegistroPage(
                          marcacao: Registro.inicioPausa,
                          bloc: bloc,
                          matricula: widget.matricula,
                        ));
                  }),
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text(Registro.terminoPausa),
              subtitle: Text('Aguardando'),
              trailing: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    push(
                        context,
                        RegistroPage(
                          marcacao: Registro.terminoPausa,
                          bloc: bloc,
                          matricula: widget.matricula,
                        ));
                  }),
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text(Registro.termino),
              subtitle: Text('Aguardando'),
              trailing: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    push(
                        context,
                        RegistroPage(
                          marcacao: Registro.termino,
                          bloc: bloc,
                          matricula: widget.matricula,
                        ));
                  }),
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
                    Text('Aguardando Registros...'),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'TOTAL DA PAUSA',
                      style: TextStyle(color: Colors.purple),
                    ),
                    Text('Aguardando Registros...'),
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
