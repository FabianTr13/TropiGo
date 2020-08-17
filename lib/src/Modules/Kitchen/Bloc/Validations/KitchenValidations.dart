import 'dart:async';

import 'package:TropiGo/src/Modules/Kitchen/Models/KitchenRecipe.dart';

class KitchenValidator {
  final validaRecipe =
      StreamTransformer<KitchenRecipe, KitchenRecipe>.fromHandlers(
          handleData: (recipe, sink) {
    sink.add(recipe);
  });
}
