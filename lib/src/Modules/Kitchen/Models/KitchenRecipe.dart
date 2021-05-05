class KitchenRecipe {
  String title;
  String description;

  factory KitchenRecipe(Map jsonMap) => KitchenRecipe.deserialize(jsonMap);

  KitchenRecipe.deserialize(Map jsonMap)
      : title = jsonMap["titulo"].toString(),
        description = jsonMap["preparacion"].toString();
}
