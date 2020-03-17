import 'package:flutter/material.dart';

class CadastroFuncionario extends StatefulWidget {
  @override
  _CadastroFuncionarioState createState() => _CadastroFuncionarioState();
}

class _CadastroFuncionarioState extends State<CadastroFuncionario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Funcionários'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                'Informe os dados abaixo para cadastrar um novo funcionário',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18,),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome Completo'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Matricula'),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Senha',
                    hintText: 'Recomendação 4 dig iniciais do CPF'),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text(
                  'CADASTRAR',
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).accentColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
