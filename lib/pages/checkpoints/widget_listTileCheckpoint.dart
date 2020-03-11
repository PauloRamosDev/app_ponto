import 'package:appponto/utils.dart';
import 'package:flutter/material.dart';

class CheckPointTile extends StatelessWidget {
  CheckPointTile(this.registro, this.registros, this.onCheckPoint);

  final registro;
  final registros;
  final VoidCallback onCheckPoint;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.access_time),
      title: Text(registro),
      subtitle: subtitle(),
      trailing: Utils().contain(registro, registros)
          ? null
          : IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                onCheckPoint();
              }),
    );
  }

  Widget subtitle() {
    return Text(Utils().contain(registro, registros) ? registros[Utils().getIndex(registro, registros)].horario:'Aguardando');
  }

}
