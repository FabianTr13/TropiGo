import 'dart:async';
import 'package:TropiGo/src/Modules/Auth/Models/Login.dart';
import 'package:rxdart/rxdart.dart';
import 'package:TropiGo/src/Modules/Auth/Bloc/Validators/AuthValidator.dart';

class AuthBloc with AuthValidator {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _emailRestoreController = BehaviorSubject<String>();

  Stream<String> get email => _emailController.stream.transform(validaEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validaPassword);
  Stream<String> get inDelivery =>
      _passwordController.stream.transform(validaPassword);
  Stream<String> get emailRestore =>
      _emailRestoreController.stream.transform(validaPassword);

  //ValidatorCombines
  Stream<bool> get submitValidLogin =>
      Rx.combineLatest2(email, password, (e, p) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeEmailRestore => _emailRestoreController.sink.add;

  Login getLogin() {
    return Login(
        email: _emailController.value, password: _passwordController.value);
  }

  String getRestartEmail() {
    return _emailRestoreController.value;
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
    _emailRestoreController.close();
  }
}

final authBlocInstance = AuthBloc();
