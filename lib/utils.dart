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
}
