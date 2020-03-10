import 'dart:async';

import 'models/model_registro.dart';


class BlocCheckPoint {

  List<Registro> registros;

  StreamController _controller = StreamController();

  get stream => _controller.stream;

  get sink => _controller.sink;

  bool contain(String marcacao) {
    bool contain = false;


    if(registros!=null)
    registros.forEach((element) {
      // ignore: unnecessary_statements
      element.registro == marcacao ? contain = true : null;
    });

    return contain;
  }

  dispose() {
    _controller.close();
  }
}
