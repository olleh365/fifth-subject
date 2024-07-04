import 'package:json_annotation/json_annotation.dart';
part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  final String main;
  final double temp;
  final String cityName;
  final double wind;
  final int humidity;
  final double tempMin;
  final double tempMax;
  final int timezone;


  WeatherModel({
    required this.main,
    required this.temp,
    required this.cityName,
    required this.wind,
    required this.humidity,
    required this.tempMin,
    required this.tempMax,
    required this.timezone
  });

  factory WeatherModel.fromJson(Map<String, dynamic>jsonData) => _$WeatherModelFromJson(jsonData);
  Map<String,dynamic> toJson() => _$WeatherModelToJson(this);

  DateTime get localTime {
    return DateTime.now().toUtc().add(Duration(seconds: timezone));
  }
}