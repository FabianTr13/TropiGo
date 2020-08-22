import 'dart:async';
import 'package:TropiGo/src/Modules/Kitchen/Bloc/Validations/KitchenValidations.dart';
import 'package:TropiGo/src/Modules/Kitchen/Models/KitchenRecipe.dart';
import 'package:rxdart/rxdart.dart';

class KitchenBloc with KitchenValidator {
  final _recipeController = BehaviorSubject<List<KitchenRecipe>>();

  Stream<List<KitchenRecipe>> get recipes =>
      _recipeController.stream.transform(validaRecipe);

  Function(List<KitchenRecipe>) get changeRecipes => _recipeController.sink.add;

  dispose() {
    _recipeController.close();
  }
}

final kitchenBlocInstance = KitchenBloc();
