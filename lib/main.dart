import 'package:appponto/pages/home/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Ponto',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.greenAccent
      ),
      home: HomePage(),
    );
  }
}

