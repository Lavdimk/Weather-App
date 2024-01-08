import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather/const.dart';
import 'package:weather/screens/weather_Details.dart';
import 'package:weather/service/weather_api';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();
  WeatherData? _weatherData;
  bool _isLoading = false;

  void _showWeatherDetails() {
    if (_weatherData != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WeatherDetails(weatherData: _weatherData!),
        ),
      );
    }
  }

  Future<void> _fetchWeatherData(String city) async {
    setState(() {
      _weatherData = null; 
      _isLoading = true;
    });

    final apiUrl = '${ApiConstants.baseUrl}${ApiConstants.apiKey}&q=$city';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final WeatherData weatherData = WeatherData.fromJson(data);
      print('All ok: ${response.statusCode}');
      setState(() {
        _weatherData = weatherData;
        _isLoading = false;
      });
      _showWeatherDetails();
    } else {
      print('Failed to load weather data. Status code: ${response.statusCode}');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[200],
          title: const Text("Weather App"),
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://img.freepik.com/free-vector/flat-design-monsoon-season-clouds-illustration_23-2149424294.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  TextField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: 'Enter city',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _fetchWeatherData(_cityController.text);
                    },
                    child: const Text('Get Weather'),
                  ),
                  const SizedBox(height: 20),
                  _isLoading
                      ? CircularProgressIndicator()
                      : SizedBox(), 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
