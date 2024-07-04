import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'weather_model.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  WeatherModel? weatherData;
  bool isLoading = false;
  final _dio = Dio();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lonController = TextEditingController();

  void fetchWeather() async {
    setState(() {
      isLoading = true;
    });
    try {
      var response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/weather',
        queryParameters: {
          'lat': _latController.text,
          'lon': _lonController.text,
          'appid': 'fe8f9cb8d0946ab928eea3124790e656',
          'units': 'metric',
        },);

      setState(() {
        weatherData = WeatherModel.fromJson(response.data);
      });
    } catch (e) {
      setState(() {
        weatherData = null;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fourth Subject App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _latController,
              decoration: const InputDecoration(
                labelText: '위도',
                hintText: '위도를 입력하시오',
              ),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: _lonController,
              decoration: const InputDecoration(
                labelText: '경도',
                hintText: '경도를 입력하시오',
              ),
              keyboardType: TextInputType.number,
            ),
            if(isLoading)
              const CircularProgressIndicator()
            else
              Column(
                children: [
                  Text('날짜: ${weatherData?.localTime}'),
                  Text('도시: ${weatherData?.cityName}'),
                  Text('날씨: ${weatherData?.main}'),
                  Text('온도: ${weatherData?.temp.toStringAsFixed(1)}°C'),
                  Text('풍속: ${weatherData?.wind}m/s'),
                  Text('습도: ${weatherData?.humidity}%'),
                  Text('최저/최고온도\n ${weatherData?.tempMax.toStringAsFixed(
                      0)}°C/ ${weatherData?.tempMin.toStringAsFixed(0)}°C')
                ],
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchWeather,
              child: const Text('날씨 호출'),
            ),
          ],
        ),
      ),
    );
  }
}