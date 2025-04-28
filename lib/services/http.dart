import 'dart:convert';
import '../models/weather.dart';
import 'package:http/http.dart' as http;

class HttpService {
  String apiKey = "7ff521c8b27a48b299d180623252704";
  final String _baseUrl = "http://api.weatherapi.com/v1/forecast.json";

  Future<Weather> getWeatherForecast(String location) async {
    String apiUrl = "$_baseUrl?key=$apiKey&q=$location&days=1"; 
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load forecast');
      }
    } catch (e) {
      throw Exception('Failed to load forecast: $e');
    }
  }
}