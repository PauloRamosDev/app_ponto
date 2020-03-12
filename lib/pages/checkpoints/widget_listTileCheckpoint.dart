import 'package:appponto/models/model_registro.dart';
import 'package:appponto/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckPointTile extends StatelessWidget {
  CheckPointTile(this.registro, this.registros, this.onCheckPoint);

  final registro;
  final registros;
  final VoidCallback onCheckPoint;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: svgIcon(),
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
    return Text(Utils().contain(registro, registros)
        ? registros[Utils().getIndex(registro, registros)].horario
        : 'Aguardando');
  }

  svgIcon() {
    var asset;

    switch (registro) {
      case Registro.inicio:
        {
          asset = 'assets/svg/stopwatch3.svg';
        }
        break;

      case Registro.inicioPausa:
        {
          asset = 'assets/svg/stopwatch.svg';
        }
        break;
      case Registro.terminoPausa:
        {
          asset = 'assets/svg/stopwatch1.svg';
        }
        break;
      case Registro.termino:
        {
          asset = 'assets/svg/stopwatch2.svg';
        }
        break;
    }

    return SvgPicture.asset(
      asset,
      width: 40,
      height: 40,
    );
  }
}
