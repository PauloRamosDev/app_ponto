import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterweb/modulo_cadastro/cadastro_store.dart';
import 'package:flutterweb/modulo_login/login_tela.dart';

class CadastroTela extends StatefulWidget {
  @override
  _CadastroTelaState createState() => _CadastroTelaState();
}

class _CadastroTelaState extends State<CadastroTela> {
  CadastroStore cadastro = CadastroStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FlutterLogo(),
            Text('Cadastro'), //nome da empresa
            Card(
              margin: EdgeInsets.all(16),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'E-MAIL',
                      style: TextStyle(color: Colors.purple),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: cadastro.setEmail,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Text(
                      'SENHA',
                      style: TextStyle(color: Colors.purple),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: cadastro.setPasword,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                    ),
                    Text(
                      'CONFIRMAR SENHA',
                      style: TextStyle(color: Colors.purple),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(

                        onChanged: cadastro.setRepasword,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                    ),
                    Observer(builder: (_) {
                      return RaisedButton(
                        onPressed: cadastro.isFormValid
                            ? () {
                                if (cadastro.isCadastroError != null) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Alerta'),
                                          content:
                                              Text(cadastro.isCadastroError),
                                        );
                                      });
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => LoginTela()));
                                }
                              }
                            : null,
                        color: Colors.greenAccent,
                        child: Text(
                          'CADASTRAR',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
