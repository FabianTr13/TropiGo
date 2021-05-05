class GpsStores {
  double lat;
  double log;
  String titulo;

  factory GpsStores(Map jsonMap) => GpsStores.deserialize(jsonMap);

  GpsStores.deserialize(Map jsonMap)
      : lat = double.parse(jsonMap["lat"].toString()),
        log = double.parse(jsonMap["log"].toString()),
        titulo = jsonMap["titulo"].toString();
}
