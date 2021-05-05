import 'dart:async';
import 'package:TropiGo/src/Modules/Kitchen/Models/KitchenRecipe.dart';

class KitchenValidator {
  final validaRecipe =
      StreamTransformer<List<KitchenRecipe>, List<KitchenRecipe>>.fromHandlers(
          handleData: (recipes, sink) {
    sink.add(recipes);
  });
}
