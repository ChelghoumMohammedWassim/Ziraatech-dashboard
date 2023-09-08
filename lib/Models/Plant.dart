class Plant{
  String id;
  String name;
  double min_humidity;
  double max_humidity;
  double min_luminosity;
  double max_luminosity;
  double min_groundHumidity;
  double max_groundHumidity;
  double min_temperature;
  double max_temperature;
  Plant({
    required this.id,
    required this.name,
    required this.min_humidity,
    required this.max_humidity,
    required this.min_luminosity,
    required this.max_luminosity,
    required this.min_groundHumidity,
    required this.max_groundHumidity,
    required this.min_temperature,
    required this.max_temperature,
  });
}

List<Plant> PlantsList=[];