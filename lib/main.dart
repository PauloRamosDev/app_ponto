import 'package:appponto/pages/configuracao/Configuracao.dart';
import 'package:appponto/pages/home/home.dart';
import 'package:appponto/preferences.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    runApp(BlocProvider(blocs: [
      Bloc((i) => Prefs(prefs)),
    ], child: MyApp(prefs: prefs)));
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final SharedPreferences prefs;

  MyApp({this.prefs});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Ponto',
      theme: ThemeData(
          primarySwatch: Colors.purple, accentColor: Colors.greenAccent),
      home: _handleCurrentScreen(),
    );
  }

  Widget _handleCurrentScreen() {
    bool empresa = (prefs.containsKey('empresa') ?? false);

    if (empresa) {
      return HomePage();
    } else {
      return PageConfiguracao();
    }
  }
}
