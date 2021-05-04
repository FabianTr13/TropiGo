import 'dart:async';
import 'package:TropiGo/src/Modules/Tips/Bloc/TipsValidations.dart';
import 'package:TropiGo/src/Modules/Tips/Models/Tips.dart';
import 'package:rxdart/rxdart.dart';

class TipsBloc with TipsValidations {
  final _tipsController = BehaviorSubject<List<Tips>>();

  Stream<List<Tips>> get tips => _tipsController.stream.transform(validaTips);

  Function(List<Tips>) get changeTips => _tipsController.sink.add;

  dispose() {
    _tipsController.close();
  }
}

final tipsBlocInstance = TipsBloc();
