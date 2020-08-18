import 'dart:async';
import 'package:TropiGo/src/Modules/Shop/Bloc/ModelsBloc/Granel.dart';
import 'package:TropiGo/src/Modules/Shop/Bloc/Validators.dart/ShopValidator.dart';
import 'package:rxdart/rxdart.dart';

class GranelBloc with ShopValidator {
  final _contractController = BehaviorSubject<String>();
  final _countGalonsController = BehaviorSubject<String>();
  final _nameBusinessController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _phoneNumberController = BehaviorSubject<String>();
  final _nameContactController = BehaviorSubject<String>();
  final _isNotContractController = BehaviorSubject<bool>();

  Stream<String> get contract =>
      _contractController.stream.transform(validaContract);
  Stream<String> get count =>
      _countGalonsController.stream.transform(validaCount);
  Stream<String> get nameBusiness =>
      _nameBusinessController.stream.transform(validaName);
  Stream<String> get email => _emailController.stream.transform(validaEmail);
  Stream<String> get phoneNumber =>
      _phoneNumberController.stream.transform(validaPhoneNumber);
  Stream<String> get nameContact =>
      _nameContactController.stream.transform(validaName);
  Stream<bool> get granelType => _isNotContractController.transform(validaType);

  Stream<bool> get submitValidGranel {
    if (_isNotContractController.value == null ||
        !_isNotContractController.value) {
      return Rx.combineLatest2(count, contract, (u, r) => true);
    } else {
      return Rx.combineLatest5(count, nameBusiness, email, phoneNumber,
          nameContact, (c, nb, e, p, nc) => true);
    }
  }

  Function(String) get changeContract => _contractController.sink.add;
  Function(String) get changeCount => _countGalonsController.sink.add;
  Function(String) get changeNameBusiness => _nameBusinessController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePhoneNumber => _phoneNumberController.sink.add;
  Function(String) get changeContact => _nameContactController.sink.add;
  Function(bool) get changeIsContract => _isNotContractController.sink.add;

  Granel getGranel() {
    return Granel(
      contract: _contractController.value,
      count: _countGalonsController.value,
      nameBusiness: _nameBusinessController.value,
      email: _emailController.value,
      phoneNumber: _phoneNumberController.value,
      contact: _nameContactController.value,
      isContract: _isNotContractController.value,
    );
  }

  dispose() {
    _contractController.close();
    _countGalonsController.close();
    _nameBusinessController.close();
    _phoneNumberController.close();
    _emailController.close();
    _phoneNumberController.close();
    _nameContactController.close();
    _isNotContractController.close();
  }
}

final granelBlocInstance = GranelBloc();
