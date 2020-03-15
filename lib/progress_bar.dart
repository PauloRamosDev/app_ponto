import 'package:flutter/material.dart';

import 'nav.dart';

class ProgressBar {
  ProgressBar(this.context);

  final context;
  var _show = false;

  bool get isShow => _show;

  show() {
    _show = true;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Processando...'),
            content: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[CircularProgressIndicator()],
            ),
          );
        });
  }

  dismiss() {
    _show = false;
    pop(context);
  }
}
