import 'dart:async';
import 'package:TropiGo/src/Modules/Auth/Models/Signup.dart';
import 'package:rxdart/rxdart.dart';
import 'package:TropiGo/src/Modules/Auth/Bloc/Validators/AuthValidator.dart';

class SignupBloc with AuthValidator {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _phoneNumberController = BehaviorSubject<String>();
  final _rePasswordController = BehaviorSubject<String>();

  //Update
  final _uIdController = BehaviorSubject<String>();
  final _newNameController = BehaviorSubject<String>();
  final _newPhoneNumberController = BehaviorSubject<String>();

  Stream<String> get email => _emailController.stream.transform(validaEmail);
  Stream<String> get name => _nameController.stream.transform(validaName);
  Stream<String> get phoneNumber =>
      _phoneNumberController.stream.transform(validaPhoneNumber);
  Stream<String> get password =>
      _passwordController.stream.transform(validaPassword);
  Stream<String> get rePassword =>
      _rePasswordController.stream.transform(validaRePassword);

  //ValidatorCombines
  Stream<bool> get submitValidSignup => Rx.combineLatest5(email, name,
      phoneNumber, password, rePassword, (e, n, p, pp, rp) => true);

  Stream<String> get uIdName => _uIdController.stream.transform(validaName);
  Stream<String> get newName => _newNameController.stream.transform(validaName);
  Stream<String> get newPhoneNumber =>
      _newPhoneNumberController.stream.transform(validaPhoneNumber);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changePhoneNumber => _phoneNumberController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeRePassword => _rePasswordController.sink.add;
  Function(String) get changNewName => _newNameController.sink.add;
  Function(String) get changeNewPhoneNumber =>
      _newPhoneNumberController.sink.add;
  Function(String) get changeUId => _uIdController.sink.add;

  String getRePassword() {
    return _passwordController.value;
  }

  Signup getSignup() {
    return Signup(
      uID: _uIdController.value,
      email: _emailController.value,
      name: _nameController.value,
      phoneNumber: _phoneNumberController.value,
      password: _passwordController.value,
      rePassword: _rePasswordController.value,
      newName: _newNameController.value,
      newPhoneNumber: _newPhoneNumberController.value,
    );
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
    _nameController.close();
    _phoneNumberController.close();
    _rePasswordController.close();
    _newNameController.close();
    _newPhoneNumberController.close();
    _uIdController.close();
  }
}

final signupBlocInstance = SignupBloc();
