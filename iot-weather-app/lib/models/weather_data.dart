class WeatherData {
  final double temperature;
  final double humidity;
  final int light;

  WeatherData({
    required this.temperature,
    required this.humidity,
    required this.light,
  });

  factory WeatherData.fromMap(Map<String, dynamic> map) {
    return WeatherData(
      temperature: map['temperature'].toDouble(),
      humidity: map['humidity'].toDouble(),
      light: map['light'],
    );
  }
}