import 'dart:async';

import 'package:TropiGo/src/Modules/Auth/Bloc/SignupBloc.dart';

class ShopValidator {
  final validaContract = StreamTransformer<String, String>.fromHandlers(
      handleData: (contract, sink) {
    if (contract.length > 2) {
      sink.add(contract);
    } else {
      sink.addError("Vacio");
    }
  });

  final validaEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final RegExp _emailRegExp =
        RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');

    if (_emailRegExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError("Correo no valido");
    }
  });

  final validaName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length > 3) {
      sink.add(name);
    } else {
      sink.addError("Nombre invalido");
    }
  });

  final validaCount =
      StreamTransformer<String, String>.fromHandlers(handleData: (count, sink) {
    int counter = int.tryParse(count) == null ? 0 : int.parse(count);
    print(counter);
    print(int.tryParse(count));
    if (counter >= 1) {
      sink.add(counter.toString());
    } else {
      sink.addError("Cantidad no valida");
    }
  });

  final validaType =
      StreamTransformer<bool, bool>.fromHandlers(handleData: (type, sink) {
    sink.add(type);
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
