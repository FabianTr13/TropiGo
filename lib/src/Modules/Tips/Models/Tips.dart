class Tips {
  String description;
  String title;

  factory Tips(Map jsonMap) => Tips.deserialize(jsonMap);

  Tips.deserialize(dynamic jsonMap)
      : title = jsonMap["titulo"].toString(),
        description = jsonMap["descripcion"].toString();

  Tips.fromJson(dynamic json)
      : title = json["titulo"],
        description = json["descripcion"];
}
