class Registro {
  static const inicio = 'INICIO DA JORNADA';
  static const inicioPausa = 'INICIO DA PAUSA';
  static const terminoPausa = 'TERMINO DA PAUSA';
  static const termino = 'TERMINO DE JORNADA';

  double longitude;
  double latitude;
  String registro; //1 - INICIO 2 - INICIO PAUSA 3 - TERMINO PAUSA 4 - TERMINO
  String pathFoto;
  String horario; // hh:mm:ss
  String data; // mm-dd-yyyy

  Registro(this.longitude, this.latitude, this.registro, this.pathFoto,
      this.horario, this.data);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['registro'] = registro;
    map['pathFoto'] = pathFoto;
    map['horario'] = horario;
    map['data'] = data;
    return map;
  }

  Registro.fromMap(Map<String, dynamic> map) {
    this.latitude = map['latitude'];
    this.longitude = map['longitude'];
    this.registro = map['registro'];
    this.pathFoto = map['pathFoto'];
    this.horario = map['horario'];
    this.data = map['data'];
  }
}
