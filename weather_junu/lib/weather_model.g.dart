// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      main: json['weather'][0]['main'] as String,
      temp: (json['main']['temp'] as num).toDouble(),
      cityName: json['name'] as String,
      wind: (json['wind']['speed'] as num).toDouble(),
      humidity: (json['main']['humidity'] as num).toInt(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      timezone: (json['timezone'] as num).toInt(),
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'main': instance.main,
      'temp': instance.temp,
      'cityName': instance.cityName,
      'wind': instance.wind,
      'humidity': instance.humidity,
      'tempMin': instance.tempMin,
      'tempMax': instance.tempMax,
      'timezone': instance.timezone,
    };
