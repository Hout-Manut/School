import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mini/Week%204/S1-Practice/weather_app/cities.dart';
import 'package:flutter_mini/Week%204/S1-Practice/weather_app/weather_service.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MaterialApp(
    color: Colors.white,
    home: SafeArea(child: WeatherScreen()),
  ));
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();

  List<Map<String, dynamic>>  weatherData = [];
  bool isLoading = true;

  Future<void> _fetchData(Cities city) async {
    setState(() {
      weatherData = [];
      isLoading = true;
    });
    final data = await _weatherService.fetchWeatherData(city);
    setState(() {
      weatherData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


}
