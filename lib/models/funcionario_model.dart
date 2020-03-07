class Funcionario {
  int id;
  String nome;
  String matricula;

  Funcionario(this.id, this.nome, this.matricula);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['id'] = id;
    map['nome'] = nome;
    map['matricula'] = matricula;

    return map;
  }

  Funcionario.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nome = map['nome'];
    this.matricula = map['matricula'];
  }
}
