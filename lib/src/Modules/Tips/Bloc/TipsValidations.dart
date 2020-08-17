import 'dart:async';

import 'package:TropiGo/src/Modules/Tips/Models/Tips.dart';

class TipsValidations {
  final validaTips =
      StreamTransformer<Tips, Tips>.fromHandlers(handleData: (tips, sink) {
    sink.add(tips);
  });
}
