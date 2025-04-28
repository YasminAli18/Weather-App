import 'package:flutter/material.dart';
import '../models/weather.dart';

class WeatherDetailPage extends StatelessWidget {
  final Weather weather;
  final String date;

  const WeatherDetailPage({super.key, required this.weather, required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF004AAD), 
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.location_pin, size: 20, color: Colors.white),
                  SizedBox(width: 5),
                  Text(
                    weather.cityName,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Image.asset(
                'assets/images/Suncloud.png',
                width: 120,
                height: 120,
              ),
              SizedBox(height: 20),

              
              Text(
                '${weather.temperature}°C',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),

              Text(
                'Precipitation',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 10),

              Text(
                'Min Temp: ${weather.minTemp}°C  |  Max Temp: ${weather.maxTemp}°C',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _detailItem(Icons.air, '${weather.wind} km/h', 'Wind'), 
                    _detailItem(Icons.thermostat_outlined, '${weather.temperature}°C', 'Temperature'),
                    _detailItem(Icons.cloud, '${weather.precipitation} mm', 'Rain'),
                  ],
                ),
              ),
              SizedBox(height: 20),

             Container(
  height: 150,
  padding: EdgeInsets.all(10),
  decoration: BoxDecoration(
    color: Colors.blue[800],
    borderRadius: BorderRadius.circular(20),
  ),
  child: ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: weather.hourlyForecast.length,
    separatorBuilder: (context, index) => SizedBox(width: 10),
    itemBuilder: (context, index) {
      final forecast = weather.hourlyForecast[index];
      return Container(
        width: 70,
        decoration: BoxDecoration(
          color: index == 2 ? Colors.blue[700] : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('${forecast.temperature.toStringAsFixed(0)}°C', style: TextStyle(color: Colors.white)),
            Image.network('http:${forecast.iconUrl}', width: 30, height: 30),
            Text(
              _formatHour(forecast.time),
              style: TextStyle(color: Colors.white70, fontSize: 10),
            ),
          ],
        ),
      );
    },
  ),
),

              SizedBox(height: 20),
             
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 25, 32, 74), 
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        SizedBox(height: 5),
        Text(value, style: TextStyle(color: Colors.white, fontSize: 16)),
      ],
    );
  }

  String _formatHour(String time) {
  final parsedTime = DateTime.parse(time);
  return '${parsedTime.hour}:${parsedTime.minute.toString().padLeft(2, '0')}';
}

}
