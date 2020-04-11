import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  _LoginStore() {
    autorun((_) {
      print(email);
      print(password);
      print(isFormValid);
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

  @computed
  bool get isFormValid => isEmailValid && isPasswordValid;

  @computed
  bool get isPasswordValid => password.length > 5;

  @computed
  bool get isEmailValid => RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$")
      .hasMatch(email);

  String get isLoginError{

    try{
      //precisa de uma função que retorna uma string com o erro.
      //se a funçao nao retornar um erro quer dizer que foi sucesso

      //ex: FirebaseAuth.signInWithEmailAndPassword(email, senha);

//      return forcarErro[5];
      return null;
    }catch(e){
      return e.toString();

    }

//    return 'Email não encontrado';
  }



}
