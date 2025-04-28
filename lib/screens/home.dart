import 'package:flutter/material.dart';
import 'weather_screen.dart'; 
import '../models/weather.dart'; // استدعاء الموديل
import '../services/http.dart'; // استدعاء خدمة الـ API

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  _WeatherHomeScreenState createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  late TextEditingController _cityController;
  bool _isLoading = false;
  Weather? _weatherObject;

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController();
  }

  // دالة لجلب بيانات الطقس من الـ API
Future<void> _getWeatherData(String cityName) async {
  setState(() {
    _isLoading = true;
  });

  try {
    var weatherObject = await HttpService().getWeatherForecast(cityName);
    
    print(weatherObject);  // اختبار الطباعة للمتحول weatherObject

    setState(() {
      _weatherObject = weatherObject;
      _isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeatherDetailPage(
          weather: _weatherObject!,
          date: '', // أو التاريخ اللي طالع معاك من الـ API
        ),
      ),
    );
  } catch (error) {
    setState(() {
      _isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to load weather data: $error')),
    );
  }
}



  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40), 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  '../../assets/images/W.png', 
                  width: 70,
                  height: 70,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Weather App',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Image.asset(
              '../../assets/images/Suncloud.png', 
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      hintText: 'Enter City Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 25, 32, 74),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isLoading
                      ? null
                      : () {
                          _getWeatherData(_cityController.text);
                        },
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Check',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
