class KitchenRecipe {
  String title;
  String description;

  factory KitchenRecipe(Map jsonMap) {
    return new KitchenRecipe.deserialize(jsonMap);
  }

  KitchenRecipe.deserialize(Map jsonMap)
      : title = jsonMap["titulo"].toString(),
        description = jsonMap["preparacion"].toString();
}
