class WeatherData {
  final DateTime time;
  final double temperature;
  final double windSpeed;

  WeatherData({
    required this.time,
    required this.temperature,
    required this.windSpeed,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      time: DateTime.parse(json['current']['time']),
      temperature: json['current']['temperature_2m'].toDouble(),
      windSpeed: json['current']['wind_speed_10m'].toDouble(),
    );
  }
}
