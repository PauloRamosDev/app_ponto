import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutterweb/cadastro_funcionario.dart';
import 'package:flutterweb/modulo_cadastro/cadastro_screen.dart';

import 'login_store.dart';

class LoginTela extends StatefulWidget {
  @override
  _LoginTelaState createState() => _LoginTelaState();
}

class _LoginTelaState extends State<LoginTela> {
  final LoginStore loginStore = LoginStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FlutterLogo(size: 200,),
            Text('Login'), //nome da empresa
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
                        onChanged: loginStore.setEmail,
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
                        onChanged: loginStore.setPasword,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                    ),
                    Observer(builder: (_) {
                      return RaisedButton(
                        onPressed: loginStore.isFormValid
                            ? () {
                                if (loginStore.isLoginError != null)
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Alerta'),
                                          content:
                                              Text(loginStore.isLoginError),
                                        );
                                      });

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => CadastroFuncionario()));

//                          loginStore.isLoginError;
                              }
                            : null,
                        color: Colors.greenAccent,
                        child: Text(
                          'ENTRAR',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }),
                    FlatButton(onPressed: ()=>Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CadastroTela())), child: Text('Me Cadastrar'))
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
