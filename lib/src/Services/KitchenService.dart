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
          value.docs.forEach(
            (element) {
              var recipe = KitchenRecipe(
                title: element.data()['titulo'],
                description: element.data()['preparacion'],
              );

              recipes.add(recipe);

              recipes.add(
                new KitchenRecipe(
                  title: "sss",
                  description: "ddddddddddd",
                ),
              );
            },
          );

          kitchenBlocInstance.changeRecipes(recipes);
        } catch (e) {}
      },
    );
    return recipes;
  }
}
