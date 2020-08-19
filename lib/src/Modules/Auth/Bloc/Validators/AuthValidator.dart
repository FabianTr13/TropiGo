import 'dart:async';

import 'package:TropiGo/src/Modules/Auth/Bloc/SignupBloc.dart';

class AuthValidator {
  final validaEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final RegExp _emailRegExp =
        RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');

    if (_emailRegExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError("Este correo es invalido");
    }
  });

  final validaPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 5) {
      sink.add(password);
    } else {
      sink.addError("La contaseña es muy corta");
    }
  });

  final validaRePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (rePassword, sink) {
    if (rePassword == signupBlocInstance.getRePassword() &&
        rePassword.length > 5) {
      sink.add(rePassword);
    } else {
      sink.addError("Las Contraseñas no coinciden");
    }
  });

  final validaName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 3) {
      sink.add(name);
    } else {
      sink.addError("Nombre incompleto");
    }
  });

  final validaPhoneNumber =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    final RegExp _phoneRegExp = RegExp(r'(^(?:[+0]9)?[0-9]{8,12}$)');
    if (_phoneRegExp.hasMatch(phone)) {
      sink.add(phone);
    } else {
      sink.addError("Telefono no valido");
    }
  });
}
