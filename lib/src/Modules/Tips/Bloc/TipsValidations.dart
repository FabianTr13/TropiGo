import 'dart:async';
import 'package:TropiGo/src/Modules/Tips/Models/Tips.dart';

class TipsValidations {
  final validaTips = StreamTransformer<List<Tips>, List<Tips>>.fromHandlers(
      handleData: (tips, sink) {
    sink.add(tips);
  });
}
