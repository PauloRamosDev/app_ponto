import 'package:intl/intl.dart';

class Utils {
  static String getData() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  static String getHora() {
    return DateFormat('HH:mm:ss').format(DateTime.now());
  }

  static int horaDiferencaMinutos(hora1, hora2) {
    var um = DateTime.parse(getData() + ' ' + hora1);
    var dois = DateTime.parse(getData() + ' ' + hora2);

    return dois.difference(um).inMinutes;
  }

  bool contain(String marcacao,registros) {
    bool contain = false;

    if (registros != null)
      registros.forEach((element) {
        // ignore: unnecessary_statements
        element.registro == marcacao ? contain = true : null;
      });

    return contain;
  }

  int getIndex(String marcacao,registros) {
    for (var i = 0; i < registros.length; ++i) {
      if (registros[i].registro == marcacao) return i;
    }
    return null;
  }
}
