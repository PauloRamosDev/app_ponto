class Empresa{
  String id;
  String nome;
  String logo;
  String cnpj;
  String endereco;
  String credencial;


  Empresa(this.id, this.nome, this.logo, this.cnpj, this.endereco,
      this.credencial);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['id'] = id;
    map['nome'] = nome;
    map['logo'] = logo;
    map['cnpj'] = cnpj;
    map['endereco'] = endereco;
    map['credencial'] = credencial;

    return map;
  }

  Empresa.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nome = map['nome'];
    this.logo = map['logo'];
    this.cnpj = map['cnpj'];
    this.endereco = map['endereco'];
    this.credencial = map['credencial'];
  }
}