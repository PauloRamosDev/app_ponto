import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs extends BlocBase {
  final SharedPreferences prefs;

  Prefs(this.prefs);

  getEmpresa() {
    if (prefs.containsKey('empresa')) {
      return jsonDecode(prefs.getString('empresa'))['nome'];
    }
    return null;
  }

  int getNoSync() {
    if (prefs.containsKey('noSync')) {
      return prefs.getInt('noSync');
    }
    return 0;
  }

  setNoSync(int value) {
    prefs.setInt('noSync', value);
    notifyListeners();
  }
}
