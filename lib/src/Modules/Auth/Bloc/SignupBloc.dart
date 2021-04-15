import 'dart:async';
import 'package:TropiGo/src/Modules/Auth/Models/Signup.dart';
import 'package:rxdart/rxdart.dart';
import 'package:TropiGo/src/Modules/Auth/Bloc/Validators/AuthValidator.dart';

class SignupBloc with AuthValidator {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _colonyController = BehaviorSubject<String>();
  final _sexoController = BehaviorSubject<String>.seeded("m");
  final _birthDayController = BehaviorSubject<String>();
  final _phoneNumberController = BehaviorSubject<String>();
  final _rePasswordController = BehaviorSubject<String>();

  //Update
  final _uIdController = BehaviorSubject<String>();
  final _newNameController = BehaviorSubject<String>();
  final _newPhoneNumberController = BehaviorSubject<String>();
  final _newSexoController = BehaviorSubject<String>.seeded("m");
  final _newBithDayController = BehaviorSubject<String>();

  Stream<String> get email => _emailController.stream.transform(validaEmail);
  Stream<String> get name => _nameController.stream.transform(validaName);
  Stream<String> get phoneNumber =>
      _phoneNumberController.stream.transform(validaPhoneNumber);

  Stream<String> get colony => _colonyController.stream.transform(validaColony);
  Stream<String> get password =>
      _passwordController.stream.transform(validaPassword);
  Stream<String> get sexo => _sexoController.stream.transform(validaSexo);

  Stream<String> get rePassword =>
      _rePasswordController.stream.transform(validaRePassword);
  Stream<String> get birthDay =>
      _birthDayController.stream.transform(validaBirthDay);

  //ValidatorCombines
  Stream<bool> get submitValidSignup => Rx.combineLatest7(
      email,
      name,
      phoneNumber,
      password,
      rePassword,
      sexo,
      birthDay,
      (e, n, p, pp, rp, s, b) => true);

  //Updates
  Stream<String> get uIdName => _uIdController.stream.transform(validaName);
  Stream<String> get newName => _newNameController.stream.transform(validaName);
  Stream<String> get newPhoneNumber =>
      _newPhoneNumberController.stream.transform(validaPhoneNumber);
  Stream<String> get newsexo => _newSexoController.stream.transform(validaSexo);
  Stream<String> get newBirthDay =>
      _newBithDayController.stream.transform(validaBirthDay);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeColony => _colonyController.sink.add;
  Function(String) get changePhoneNumber => _phoneNumberController.sink.add;
  Function(String) get changeSexo => _sexoController.sink.add;
  Function(String) get changeBirthDate => _birthDayController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeRePassword => _rePasswordController.sink.add;
  Function(String) get changNewName => _newNameController.sink.add;
  Function(String) get changeNewPhoneNumber =>
      _newPhoneNumberController.sink.add;
  Function(String) get changeUId => _uIdController.sink.add;
  Function(String) get changeNewSex => _newSexoController.sink.add;
  Function(String) get changeNewBirthDay => _newBithDayController.sink.add;

  String getRePassword() {
    return _passwordController.value;
  }

  Signup getSignup(cityId, cityName) {
    return Signup(
      uID: _uIdController.value,
      email: _emailController.value,
      name: _nameController.value,
      phoneNumber: _phoneNumberController.value,
      colony: _colonyController.value,
      cityId: cityId,
      cityName: cityName,
      sexo: _sexoController.value,
      birthday: _birthDayController.value,
      password: _passwordController.value,
      rePassword: _rePasswordController.value,
      newName: _newNameController.value,
      newPhoneNumber: _newPhoneNumberController.value,
      newSexo: _newSexoController.value,
      newBirthDay: _newBithDayController.value,
    );
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
    _nameController.close();
    _colonyController.close();
    _phoneNumberController.close();
    _rePasswordController.close();
    _newNameController.close();
    _newPhoneNumberController.close();
    _uIdController.close();
    _sexoController.close();
    _birthDayController.close();
    _newSexoController.close();
    _newBithDayController.close();
  }
}

final signupBlocInstance = SignupBloc();
