import 'dart:async';
import '../../models/model_registro.dart';

class BlocCheckPoint {
  BlocCheckPoint();

  List<Registro> registros;

  StreamController _controller = StreamController<List<Registro>>();

  Stream<List<Registro>> get stream => _controller.stream;

  StreamSink<List<Registro>> get sink => _controller.sink;

  bool contain(String marcacao) {
    bool contain = false;

    if (registros != null)
      registros.forEach((element) {
        // ignore: unnecessary_statements
        element.registro == marcacao ? contain = true : null;
      });

    return contain;
  }

  int getIndex(String marcacao) {
    for (var i = 0; i < registros.length; ++i) {
      if (registros[i].registro == marcacao) return i;
    }
    return null;
  }

  dispose() {
    _controller.close();
  }
}
