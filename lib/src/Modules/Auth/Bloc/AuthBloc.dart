import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:TropiGo/src/Modules/Auth/Bloc/Validators.dart/AuthValidator.dart';

class AuthBloc with AuthValidator {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  final _nameController = StreamController<String>.broadcast();
  final _phoneNumberController = StreamController<String>.broadcast();
  final _passwordSignupController = StreamController<String>.broadcast();
  final _repasswordSignupController = StreamController<String>.broadcast();

  Stream<String> get email => _emailController.stream.transform(validaEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validaPassword);
  Stream<String> get passwordSignup =>
      _passwordSignupController.stream.transform(validaPassword);
  Stream<String> get rePasswordSignup =>
      _repasswordSignupController.stream.transform(validaPassword);
  Stream<String> get name => _nameController.stream.transform(validaName);
  Stream<String> get phoneNumber =>
      _phoneNumberController.stream.transform(validaPhoneNumber);

  //ValidatorCombines
  Stream<bool> get submitValidLogin =>
      Rx.combineLatest2(email, password, (e, p) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changePasswordSignup => _passwordController.sink.add;
  Function(String) get changeRePasswordSignup => _passwordController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changePhoneNumber => _phoneNumberController.sink.add;

  dispose() {
    _emailController.close();
    _passwordController.close();
    _nameController.close();
    _phoneNumberController.close();
    _repasswordSignupController.close();
    _passwordSignupController.close();
  }
}

final authBlocInstance = AuthBloc();
