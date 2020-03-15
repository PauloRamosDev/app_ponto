import 'dart:convert';

import 'package:appponto/models/empresa_model.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs extends BlocBase {
  final SharedPreferences prefs;

  Prefs(this.prefs);

  Empresa getEmpresa() {
    //id - nome - cnpj - endereco - log - credencial
    if (prefs.containsKey('empresa')) {
      return Empresa.fromMap(jsonDecode(prefs.getString('empresa')));
    }
    return null;
  }

  Future<bool> setEmpresa(empresa) async {
    return prefs.setString('empresa', jsonEncode(empresa));
  }

  int getNoSync() {
    if (prefs.containsKey('noSync')) {
      return prefs.getInt('noSync');
    }
    return 0;
  }

  void setNoSync(int value) {
    prefs.setInt('noSync', value);
    notifyListeners();
  }
}
