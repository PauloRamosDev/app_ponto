import 'package:appponto/pages/checkpoints/bloc_check_point.dart';
import 'package:appponto/models/model_registro.dart';
import 'package:appponto/nav.dart';
import 'package:appponto/pages/checkpoints/registro_ponto.dart';
import 'package:appponto/utils.dart';
import 'package:appponto/pages/checkpoints/widget_listTileCheckpoint.dart';
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

//    widget.listaCheckPoints.forEach((r)=>print(r.toMap().toString()));
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
//            ListTile(
//              leading: Icon(Icons.access_time),
//              title: Text(Registro.inicio),
//              subtitle: subtitle(Registro.inicio),
//              trailing: !bloc.contain(Registro.inicio)
//                  ? IconButton(
//                  icon: Icon(Icons.arrow_forward),
//                  onPressed: () {
//                    push(
//                        context,
//                        RegistroPage(
//                          bloc: bloc,
//                          marcacao: Registro.inicio,
//                          matricula: widget.matricula,
//                        ));
//                  })
//                  : null,
//            ),
            CheckPointTile(Registro.inicio, bloc.registros, () {
              push(
                  context,
                  RegistroPage(
                    bloc: bloc,
                    marcacao: Registro.inicio,
                    matricula: widget.matricula,
                  ));
            }),
            CheckPointTile(Registro.inicioPausa, bloc.registros, () {
              push(
                  context,
                  RegistroPage(
                    bloc: bloc,
                    marcacao: Registro.inicioPausa,
                    matricula: widget.matricula,
                  ));
            }),
            CheckPointTile(Registro.terminoPausa,
                bloc.registros,
                () {
              push(
                  context,
                  RegistroPage(
                    bloc: bloc,
                    marcacao: Registro.terminoPausa,
                    matricula: widget.matricula,
                  ));
            }),
            CheckPointTile(Registro.termino,
                bloc.registros, () {
              push(
                  context,
                  RegistroPage(
                    bloc: bloc,
                    marcacao: Registro.termino,
                    matricula: widget.matricula,
                  ));
            }),
//            ListTile(
//              leading: Icon(Icons.access_time),
//              title: Text(Registro.inicioPausa),
//              subtitle: subtitle(Registro.inicioPausa, snapshot.data),
//              trailing:
//              !bloc.contain(Registro.inicioPausa, snapshot.data)
//                  ? IconButton(
//                  icon: Icon(Icons.arrow_forward),
//                  onPressed: () {
//                    push(
//                        context,
//                        RegistroPage(
//                          bloc: bloc,
//                          marcacao: Registro.inicioPausa,
//                          matricula: widget.matricula,
//                        ));
//
//                  })
//                  : null,
//            ),
//            ListTile(
//              leading: Icon(Icons.access_time),
//              title: Text(Registro.terminoPausa),
//              subtitle: subtitle(Registro.terminoPausa, snapshot.data),
//              trailing:
//              !bloc.contain(Registro.terminoPausa, snapshot.data)
//                  ? IconButton(
//                  icon: Icon(Icons.arrow_forward),
//                  onPressed: () {
//                    push(
//                        context,
//                        RegistroPage(
//                          bloc: bloc,
//                          marcacao: Registro.terminoPausa,
//                          matricula: widget.matricula,
//                        ));
//                  })
//                  : null,
//            ),
//            ListTile(
//              leading: Icon(Icons.access_time),
//              title: Text(Registro.termino),
//              subtitle: subtitle(Registro.termino, snapshot.data),
//              trailing: !bloc.contain(Registro.termino, snapshot.data)
//                  ? IconButton(
//                  icon: Icon(Icons.arrow_forward),
//                  onPressed: () {
//                    push(
//                        context,
//                        RegistroPage(
//                          bloc: bloc,
//                          marcacao: Registro.termino,
//                          matricula: widget.matricula,
//                        ));
//                  })
//                  : null,
//            ),
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
                        ? Utils.horaDiferencaMinutos(
                                    bloc
                                        .registros[bloc.getIndex(
                                      Registro.inicio,
                                    )]
                                        .horario,
                                    bloc
                                        .registros[bloc.getIndex(
                                      Registro.termino,
                                    )]
                                        .horario)
                                .toString() +
                            ' Minutos'
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
                        ? Utils.horaDiferencaMinutos(
                                    bloc
                                        .registros[bloc.getIndex(
                                      Registro.inicioPausa,
                                    )]
                                        .horario,
                                    bloc
                                        .registros[bloc.getIndex(
                                      Registro.terminoPausa,
                                    )]
                                        .horario)
                                .toString() +
                            ' Minutos'
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

  Widget subtitle(marcacao) {
    return Text(bloc.contain(marcacao) == true
        ? bloc.registros[bloc.getIndex(marcacao)].horario
        : 'Aguardando');
  }
}
