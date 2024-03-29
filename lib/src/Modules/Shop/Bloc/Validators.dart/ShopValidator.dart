import 'dart:async';
import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/Product.dart';
import 'package:location/location.dart';

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

  final validaGallones =
      StreamTransformer<String, String>.fromHandlers(handleData: (count, sink) {
    int counter = int.tryParse(count) == null ? 0 : int.parse(count);
    if (counter >= 1) {
      sink.add(counter.toString());
    } else {
      sink.addError("Cantidad no valida");
    }
  });

  final validaCounter =
      StreamTransformer<int, int>.fromHandlers(handleData: (count, sink) {
    if (count >= 1) {
      sink.add(count);
    } else {
      sink.addError("Cantidad no valida");
    }
  });

  final validaType =
      StreamTransformer<bool, bool>.fromHandlers(handleData: (type, sink) {
    sink.add(type);
  });

  final validaProduct =
      StreamTransformer<List<Product>, List<Product>>.fromHandlers(
          handleData: (product, sink) {
    sink.add(product);
  });

  final validaLocation =
      StreamTransformer<LocationData, LocationData>.fromHandlers(
          handleData: (location, sink) {
    sink.add(location);
  });

  final validaProductSelect = StreamTransformer<Product, Product>.fromHandlers(
      handleData: (product, sink) {
    if (product != null) {
      if (product.isSelect != null && product.isSelect) {
        sink.add(product);
      } else {
        sink.addError("No product");
      }
    } else {
      sink.addError("No product");
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
