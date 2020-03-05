import 'dart:async';

import 'package:flutter/material.dart';

class Relogio extends StatefulWidget {
  @override
  _RelogioState createState() => _RelogioState();
}

class _RelogioState extends State<Relogio> {
  var _time;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(hora(),style: TextStyle(fontWeight:FontWeight.bold,fontSize: 30),),
    );
  }

  _loop() {
    return Timer.periodic(Duration(seconds: 1), (t) => _set());
  }

  _set() {
    setState(() {
      print('setstate');
    });
  }

  @override
  void didChangeDependencies() {
    _time = _loop();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _time.cancel();
    super.dispose();
  }
}

String hora() {

  return DateTime.now().hour.toString() +
      ':' +
      DateTime.now().minute.toString().padLeft(2, '0') +
      ':' +
      DateTime.now().second.toString().padLeft(2, '0');
}
