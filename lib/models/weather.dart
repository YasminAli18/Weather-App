

class HourlyForecast {
  final String time;
  final double temperature;
  final String iconUrl;

  HourlyForecast({
    required this.time,
    required this.temperature,
    required this.iconUrl,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: json['time'],
      temperature: json['temp_c'],
      iconUrl: json['condition']['icon'],
    );
  }
}

class Weather {
  final String cityName;
  final double temperature;
  final String condition;
  final double precipitation;
  final double humidity;
  final double wind;
  final double maxTemp;
  final double minTemp;
  final List<HourlyForecast> hourlyForecast;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.precipitation,
    required this.humidity,
    required this.wind,
    required this.maxTemp,
    required this.minTemp,
    required this.hourlyForecast,
  });


  double get windSpeed => wind;
  double get rainProbability => precipitation;

  factory Weather.fromJson(Map<String, dynamic> json) {
    var hourlyList = json['forecast']['forecastday'][0]['hour'] as List;
    List<HourlyForecast> hourlyForecast = hourlyList.map((i) => HourlyForecast.fromJson(i)).toList();

    return Weather(
      cityName: json['location']['name'],
      temperature: json['current']['temp_c'],
      condition: json['current']['condition']['text'],
      precipitation: json['current']['precip_mm'],
      humidity: json['current']['humidity'],
      wind: json['current']['wind_kph'],
      maxTemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
      minTemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
      hourlyForecast: hourlyForecast,
    );
  }
}