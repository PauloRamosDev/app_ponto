class Funcionario {
  int id;
  String nome;
  String matricula;
  String senha;
  int ativo;

  Funcionario(this.id, this.nome, this.matricula,this.senha,this.ativo);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['id'] = id;
    map['nome'] = nome;
    map['matricula'] = matricula;
    map['senha'] = senha;
    map['ativo'] = ativo;

    return map;
  }

  Funcionario.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nome = map['nome'];
    this.matricula = map['matricula'];
    this.senha = map['senha'];
    this.ativo = map['ativo'];
  }
}
