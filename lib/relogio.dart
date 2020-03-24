import 'dart:async';

import 'package:appponto/utils.dart';
import 'package:flutter/material.dart';

class Relogio extends StatefulWidget {
  @override
  _RelogioState createState() => _RelogioState();
}

class _RelogioState extends State<Relogio> {
  Timer _time;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        Utils.getHora(),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      ),
    );
  }

  _loop() {
    return Timer.periodic(Duration(seconds: 1), (t) => _set());
  }

  _set() {
    setState(() {});
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
