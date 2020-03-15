import 'dart:convert';

import 'package:appponto/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../firebase/firebase_helper.dart';
import '../../nav.dart';
import '../home/home.dart';

class PageConfiguracao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var progressbar = ProgressBar(context);
    var login = TextEditingController();
    var credencial = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text('Login Empresa'),
            TextFormField(
              controller: login,
            ),
            Text('Credencial'),
            TextFormField(),
            RaisedButton(
              onPressed: () async {
                progressbar.show();

                var empresa = await FirebaseHelper(login.text)
                    .getEmpresa()
                    .timeout(Duration(seconds: 5), onTimeout: () => null);

                if (empresa != null && empresa.containsKey('nome')) {
                  print('empresa encontrada');

                  SharedPreferences.getInstance().then((prefs) {
                    prefs.setString('empresa', jsonEncode(empresa));

                    push(context, HomePage(), replace: true);
                  });

                  progressbar.dismiss();
                } else {
                  print('empresa nao encontrada');
                  progressbar.dismiss();

                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text(
                            'Erro!',
                            textAlign: TextAlign.center,
                          ),
                          content: Text(
                            'Não foi possivel conectar dados com a empresa.\n'
                            'Verifique os dados e tente novamente.',
                            textAlign: TextAlign.center,
                          ),
                        );
                      });
                }
              },
              child: Text(
                'CONECTAR',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
