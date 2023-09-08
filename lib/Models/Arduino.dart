class Arduino{
  String id;
  String name;
  double humidity;
  double luminosity;
  double groundHumidity;
  double temperature;
  double desiredTemperature;
  double desiredGroundHumidity;
  double light;

  Arduino({
    required this.id,
    required this.name,
    required this.humidity,
    required this.luminosity,
    required this.groundHumidity,
    required this.temperature,
    required this.desiredTemperature,
    required this.desiredGroundHumidity,
    required this.light
    });
  
}