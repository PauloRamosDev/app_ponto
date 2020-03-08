class Registro {
  static const inicio = 'INICIO DA JORNADA';
  static const inicioPausa = 'INICIO DA PAUSA';
  static const terminoPausa = 'TERMINO DA PAUSA';
  static const termino = 'TERMINO DE JORNADA';

  String longitude;
  String latitude;
  String registro; //1 - INICIO 2 - INICIO PAUSA 3 - TERMINO PAUSA 4 - TERMINO
  String pathFoto;
  String horario; // hh:mm:ss
  String data; // mm-dd-yyyy
  int sync; // 0 - falso 1 - verdadeiro
  String matricula;

  Registro(this.longitude, this.latitude, this.registro, this.pathFoto,
      this.horario, this.data, this.sync, this.matricula);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['longitude'] = longitude;
    map['latitude'] = latitude;
    map['registro'] = registro;
    map['pathFoto'] = pathFoto;
    map['horario'] = horario;
    map['data'] = data;
    map['matricula'] = matricula;
    map['sync'] = sync;

    return map;
  }

  Registro.fromMap(Map<String, dynamic> map) {
    this.latitude = map['latitude'];
    this.longitude = map['longitude'];
    this.registro = map['registro'];
    this.pathFoto = map['pathFoto'];
    this.horario = map['horario'];
    this.data = map['data'];
    this.matricula = map['matricula'];
    this.sync = map['sync'];
  }
}
