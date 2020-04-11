import 'package:mobx/mobx.dart';

part 'cadastro_store.g.dart';

class CadastroStore = _CadastroStore with _$CadastroStore;

abstract class _CadastroStore with Store {
  _CadastroStore() {
    autorun((_) {
      print('email '+email);
      print('password '+password);
      print('repassword '+repassword);
      print('form is valid '+ isFormValid.toString());
      print('error is '+ error);
      print(this.toString());
    });
  }

  @observable
  String email = '';

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = '';

  @action
  void setPasword(String value) => password = value;

  @observable
  String repassword = '';

  @action
  void setRepasword(String value) => repassword = value;

  @computed
  bool get isFormValid => isEmailValid && isPasswordValid;

  @computed
  bool get isPasswordValid =>
      repassword.length > 5 && password == repassword;

  @computed
  bool get isEmailValid => RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
      .hasMatch(email);

  String get isCadastroError {
    try {
      //precisa de uma função que retorna uma string com o erro.
      //se a funçao nao retornar um erro quer dizer que foi sucesso

      //ex: firebase.auth().createUserWithEmailAndPassword(email, password);

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @computed
  String get error =>isPasswordValid?'':'Senha diferente';
}
