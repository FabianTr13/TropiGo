import 'dart:async';
import 'package:TropiGo/src/Modules/Auth/Bloc/ModelsBloc.dart/Login.dart';
import 'package:rxdart/rxdart.dart';
import 'package:TropiGo/src/Modules/Auth/Bloc/Validators.dart/AuthValidator.dart';

class AuthBloc with AuthValidator {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get email => _emailController.stream.transform(validaEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validaPassword);

  //ValidatorCombines
  Stream<bool> get submitValidLogin =>
      Rx.combineLatest2(email, password, (e, p) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Login getLogin() {
    return Login(
      email: _emailController.value,
      password: _passwordController.value,
    );
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

final authBlocInstance = AuthBloc();
