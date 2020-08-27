class Tips {
  String description;
  String title;

  factory Tips(Map jsonMap) {
    return new Tips.deserialize(jsonMap);
  }

  Tips.deserialize(Map jsonMap)
      : title = jsonMap["titulo"].toString(),
        description = jsonMap["descripcion"].toString();
}
