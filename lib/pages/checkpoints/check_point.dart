import 'package:appponto/models/model_registro.dart';
import 'package:appponto/nav.dart';
import 'package:appponto/pages/checkpoints/bloc_check_point.dart';
import 'package:appponto/pages/checkpoints/registro_ponto.dart';
import 'package:appponto/pages/checkpoints/widget_listTileCheckpoint.dart';
import 'package:appponto/utils.dart';
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
        title: Text('Registros'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
            CheckPointTile(Registro.terminoPausa, bloc.registros, () {
              push(
                  context,
                  RegistroPage(
                    bloc: bloc,
                    marcacao: Registro.terminoPausa,
                    matricula: widget.matricula,
                  ));
            }),
            CheckPointTile(Registro.termino, bloc.registros, () {
              push(
                  context,
                  RegistroPage(
                    bloc: bloc,
                    marcacao: Registro.termino,
                    matricula: widget.matricula,
                  ));
            }),
            SizedBox(
              height: 50,
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
                    Text(tempoDecorrido(Registro.inicio, Registro.termino)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'TOTAL DA PAUSA',
                      style: TextStyle(color: Colors.purple),
                    ),
                    Text(tempoDecorrido(
                        Registro.inicioPausa, Registro.terminoPausa)),
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

  String tempoDecorrido(inicio, termino) {
    if (bloc.contain(inicio) && bloc.contain(termino)) {
      var min = Utils.horaDiferencaMinutos(
          bloc.registros[bloc.getIndex(inicio)].horario,
          bloc.registros[bloc.getIndex(termino)].horario);

      return '${min.toString().padLeft(2, '0')} min';
    }

    return '00 min';
  }

//  Widget _subtitle(marcacao) {
//    return Text(bloc.contain(marcacao) == true
//        ? bloc.registros[bloc.getIndex(marcacao)].horario
//        : 'Aguardando');
//  }
}
