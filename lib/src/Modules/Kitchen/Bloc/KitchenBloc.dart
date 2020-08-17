import 'dart:async';
import 'package:TropiGo/src/Modules/Kitchen/Bloc/Validations/KitchenValidations.dart';
import 'package:TropiGo/src/Modules/Kitchen/Models/KitchenRecipe.dart';
import 'package:rxdart/rxdart.dart';

class KitchenBloc with KitchenValidator {
  final _recipeController =
      BehaviorSubject<KitchenRecipe>.seeded(new KitchenRecipe());

  Stream<KitchenRecipe> get recipe =>
      _recipeController.stream.transform(validaRecipe);

  Function(KitchenRecipe) get changeRecipe => _recipeController.sink.add;

  dispose() {
    _recipeController.close();
  }
}

final kitchenBlocInstance = KitchenBloc();
