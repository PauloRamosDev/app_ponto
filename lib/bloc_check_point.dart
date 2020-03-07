import 'dart:async';

import 'file:///C:/Users/paulo/Desktop/apps_flutter/app_ponto/lib/models/model_registro.dart';

class BlocCheckPoint{


  bool fistRegister = false;
  bool secondRegister = false;
  bool third = false;
  bool fourthRegister = false;

  List<Registro> registros;

  StreamController _controller = StreamController();

  get stream => _controller.stream;
  get sink => _controller.sink;






  dispose(){
    _controller.close();
  }

}