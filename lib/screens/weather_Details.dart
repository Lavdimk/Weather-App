import 'package:flutter/material.dart';
import 'package:weather/service/weather_api';

class WeatherDetails extends StatelessWidget {
  final WeatherData weatherData;

  const WeatherDetails({Key? key, required this.weatherData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' ${weatherData.location.name},\n${weatherData.location.region},\n${weatherData.location.country}',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.network(
                    'https:${weatherData.current.condition.icon}',
                    width: 100,
                    height: 100,
                  ),
                  Text(' ${weatherData.current.tempC}°C',
                      style:
                          const TextStyle(color: Colors.black, fontSize: 40)),
                  Text(' ${weatherData.current.condition.text}',
                      style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 25,
                          fontWeight: FontWeight.w400)),
                  Text(
                      'Wind: ${weatherData.current.windMph} mph, ${weatherData.current.windDir}',
                      style:
                          const TextStyle(color: Colors.black, fontSize: 25)),
                  Text('Cloud: ${weatherData.current.cloud}%',
                      style:
                          const TextStyle(color: Colors.black, fontSize: 25)),
                  const SizedBox(
                    height: 200,
                  ),
                  Text(
                    ' ${weatherData.location.localTime}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
