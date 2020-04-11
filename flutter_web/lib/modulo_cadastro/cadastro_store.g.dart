// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CadastroStore on _CadastroStore, Store {
  Computed<bool> _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid)).value;
  Computed<bool> _$isPasswordValidComputed;

  @override
  bool get isPasswordValid => (_$isPasswordValidComputed ??=
          Computed<bool>(() => super.isPasswordValid))
      .value;
  Computed<bool> _$isEmailValidComputed;

  @override
  bool get isEmailValid =>
      (_$isEmailValidComputed ??= Computed<bool>(() => super.isEmailValid))
          .value;
  Computed<String> _$errorComputed;

  @override
  String get error =>
      (_$errorComputed ??= Computed<String>(() => super.error)).value;

  final _$emailAtom = Atom(name: '_CadastroStore.email');

  @override
  String get email {
    _$emailAtom.context.enforceReadPolicy(_$emailAtom);
    _$emailAtom.reportObserved();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.context.conditionallyRunInAction(() {
      super.email = value;
      _$emailAtom.reportChanged();
    }, _$emailAtom, name: '${_$emailAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_CadastroStore.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }

  final _$repasswordAtom = Atom(name: '_CadastroStore.repassword');

  @override
  String get repassword {
    _$repasswordAtom.context.enforceReadPolicy(_$repasswordAtom);
    _$repasswordAtom.reportObserved();
    return super.repassword;
  }

  @override
  set repassword(String value) {
    _$repasswordAtom.context.conditionallyRunInAction(() {
      super.repassword = value;
      _$repasswordAtom.reportChanged();
    }, _$repasswordAtom, name: '${_$repasswordAtom.name}_set');
  }

  final _$_CadastroStoreActionController =
      ActionController(name: '_CadastroStore');

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_CadastroStoreActionController.startAction();
    try {
      return super.setEmail(value);
    } finally {
      _$_CadastroStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPasword(String value) {
    final _$actionInfo = _$_CadastroStoreActionController.startAction();
    try {
      return super.setPasword(value);
    } finally {
      _$_CadastroStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRepasword(String value) {
    final _$actionInfo = _$_CadastroStoreActionController.startAction();
    try {
      return super.setRepasword(value);
    } finally {
      _$_CadastroStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'email: ${email.toString()},password: ${password.toString()},repassword: ${repassword.toString()},isFormValid: ${isFormValid.toString()},isPasswordValid: ${isPasswordValid.toString()},isEmailValid: ${isEmailValid.toString()},error: ${error.toString()}';
    return '{$string}';
  }
}
