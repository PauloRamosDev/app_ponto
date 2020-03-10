import 'package:appponto/bloc_check_point.dart';
import 'package:appponto/models/model_registro.dart';
import 'package:appponto/nav.dart';
import 'package:appponto/registro_ponto.dart';
import 'package:appponto/utils.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class CheckPointPage extends StatefulWidget {
  final matricula;
  final List<Registro> listaCheckPoints;

  CheckPointPage({@required this.matricula, @required this.listaCheckPoints});

  @override
  _CheckPointPageState createState() => _CheckPointPageState();
}

class _CheckPointPageState extends State<CheckPointPage> {
  BlocCheckPoint bloc = BlocCheckPoint();

  @override
  void initState() {
    bloc.registros = widget.listaCheckPoints;
    print(widget.listaCheckPoints?.length ?? 0);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
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
              subtitle: Text(bloc.contain(Registro.inicio) == true
                  ? bloc.registros[0].horario
                  : 'Aguardando'),
              trailing: !bloc.contain(Registro.inicio)
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
              subtitle: Text(bloc.contain(Registro.inicioPausa) == true
                  ? bloc.registros[1].horario
                  : 'Aguardando'),
              trailing: !bloc.contain(Registro.inicioPausa)
                  ? IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        push(
                            context,
                            RegistroPage(
                              bloc: bloc,
                              marcacao: Registro.inicioPausa,
                              matricula: widget.matricula,
                            ));
                      })
                  : null,
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text(Registro.terminoPausa),
              subtitle: Text(bloc.contain(Registro.terminoPausa) == true
                  ? bloc.registros[2].horario
                  : 'Aguardando'),
              trailing: !bloc.contain(Registro.terminoPausa)
                  ? IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        push(
                            context,
                            RegistroPage(
                              bloc: bloc,
                              marcacao: Registro.terminoPausa,
                              matricula: widget.matricula,
                            ));
                      })
                  : null,
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text(Registro.termino),
              subtitle: Text(bloc.contain(Registro.termino) == true
                  ? bloc.registros[3].horario
                  : 'Aguardando'),
              trailing: !bloc.contain(Registro.termino)
                  ? IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        push(
                            context,
                            RegistroPage(
                              bloc: bloc,
                              marcacao: Registro.termino,
                              matricula: widget.matricula,
                            ));
                      })
                  : null,
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
                    Text(bloc.contain(Registro.inicio) &&
                            bloc.contain(Registro.termino)
                        ? Utils.horaDiferencaMinutos(bloc.registros[0].horario,
                                bloc.registros[3].horario).toString()
                            +' Minutos'
                        : 'Aguardando Registros...'),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'TOTAL DA PAUSA',
                      style: TextStyle(color: Colors.purple),
                    ),
                    Text(bloc.contain(Registro.inicioPausa) &&
                            bloc.contain(Registro.terminoPausa)
                        ? Utils.horaDiferencaMinutos(bloc.registros[1].horario,
                                bloc.registros[2].horario)
                            .toString() +' Minutos'
                        : 'Aguardando Registros...'),
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
