import 'package:TropiGo/src/Modules/Kitchen/Bloc/KitchenBloc.dart';
import 'package:TropiGo/src/Modules/Kitchen/Models/KitchenRecipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KitchenServise {
  final _fireStore = Firestore.instance;

  Future<KitchenRecipe> getRecipes() async {
    KitchenRecipe recipe;
    await _fireStore.collection('tropicocina').document("0").get().then(
      (value) {
        try {
          recipe = KitchenRecipe(
            recipe: value.data['preparacion'],
            title: value.data['titulo'],
          );
          kitchenBlocInstance.changeRecipe(recipe);
        } catch (e) {}
      },
    );
    return recipe;
  }
}
