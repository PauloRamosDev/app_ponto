import 'package:appponto/firebase/firebase_helper.dart';
import 'package:appponto/pages/home/home.dart';
import 'package:appponto/preferences.dart';
import 'package:appponto/sqlite/funcionario_dao.dart';
import 'package:appponto/sqlite/registro_dao.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../nav.dart';
import '../../progress_bar.dart';

class ConfiguracaoEmpresa extends StatelessWidget {
  final provPrefs = BlocProvider.getBloc<Prefs>();

  @override
  Widget build(BuildContext context) {
    var progressbar = ProgressBar(context);
    var login = TextEditingController();
//    var credencial = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dados Iniciais'),
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

                //buscar empresa no firebase
                var empresa = await FirebaseHelper(login.text)
                    .getEmpresa()
                    .timeout(Duration(seconds: 5), onTimeout: () => null);

                if (empresa != null && empresa.containsKey('nome')) {
                  print('empresa encontrada');

                  var noSync = await RegistroDAO().existNoSync();

                  if (noSync) {
                    progressbar.dismiss();
                    //Possui dados sem sincronizar que serao perdidos
                    info(context,
                        'Você tem registros a enviar.\n Sincrozine os dados para poder proceguir!');
                  } else {
                    if (await provPrefs.setEmpresa(empresa)) {
                       await FuncionarioDAO().deleteAll();
                       await RegistroDAO().deleteAll();
                       progressbar.dismiss();

                       FirebaseHelper(empresa['id']).getFuncionarios().then((listFun) {
                         listFun.forEach((funcionario) {
                           FuncionarioDAO().insert(funcionario);
                         });
                       });

                       resetAndOpenPage(context, HomePage());

                    }else{
                      info(context,
                          'Erro inesperado!\nVerifique os dados e se tem internet antes de tentar confirgura a empresa.');
                    }

                  }

//                  progressbar.dismiss();
                } else {
                  print('empresa nao encontrada');
                  progressbar.dismiss();

                  info(
                      context,
                      'Não foi possivel conectar dados com a empresa.\n'
                      'Verifique os dados e tente novamente.');
                }
              },
              child: Text(
                'CONECTAR',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              color: Theme.of(context).accentColor,
            ),
            Text('Empresa conectada'),
            Text(provPrefs.getEmpresa()?.nome ?? 'Nenhuma'),
          ],
        ),
      ),
    );
  }

  info(context, mensagem) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              'Informação!',
              textAlign: TextAlign.center,
            ),
            content: Text(
              mensagem,
              textAlign: TextAlign.center,
            ),
          );
        });
  }
}
