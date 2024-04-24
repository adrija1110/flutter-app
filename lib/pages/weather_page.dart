import "package:flutter/material.dart";
import "package:flutter_application/models/weather_model.dart";
import "package:flutter_application/services/weather_service.dart";
import "package:lottie/lottie.dart";

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //api Key
  final _weatherService = WeatherService('4c227785e3f6c545edc9ad552e1aba12');
  Weather? _weather;

  //fetch weather 
  _fetchWeather() async {
    // get current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for the city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    catch (e) {
      // ignore: avoid_print
      print(e);

    }
  }

  //weather animations 
  String getWeatherAnimations(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/windy.json';
      case 'rain':
      case 'drizzle':
        return 'assets/rain.json';
      case 'shower rain':
        return 'assets/storm.json';
      case 'night':
        return 'assets/night.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
      
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[800],
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Corrected placement
        children: [
          Text(_weather?.cityName ?? "loading city.."), // Removed extra comma

          Lottie.asset(getWeatherAnimations(_weather?.mainCondition)),

          Text('${_weather?.temperature.round()}°C'),

          Text(_weather?.mainCondition ?? "")
        ],
      ),
    ),
  );
  }
}