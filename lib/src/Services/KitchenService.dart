import 'package:TropiGo/src/Modules/Kitchen/Bloc/KitchenBloc.dart';
import 'package:TropiGo/src/Modules/Kitchen/Models/KitchenRecipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class KitchenServise {
  final _fireStore = FirebaseFirestore.instance;

  Future<List<KitchenRecipe>> getRecipes() async {
    List<KitchenRecipe> recipes = List<KitchenRecipe>();
    await _fireStore.collection('tropicocina').get().then(
      (value) {
        try {
          recipes = value.docs
              .map<KitchenRecipe>((item) => new KitchenRecipe(item.data()))
              .toList();

          kitchenBlocInstance.changeRecipes(recipes);
        } catch (e) {}
      },
    );
    return recipes;
  }
}
