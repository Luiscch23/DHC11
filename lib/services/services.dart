import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

int hour = 0;
int minute = 0;
int second = 0;
int day = 0;
int month = 0;
int year = 0;
List<double> temperatureList = [];
List<TemperatureData> generateData() {
  // Aquí debes obtener tus datos de temperatura y tiempo de tu fuente de datos
  // Por ejemplo, desde una base de datos o una API

  List<TemperatureData> data = [
    TemperatureData(DateTime(2023, 5, 1, hour, 0, 0), 26.0),

    // Agrega más datos aquí
  ];
  for (int i = 2; i <= 10; i++) {
    DateTime dateTime = DateTime(2023, 5, i, i, 0, 0);
    double temperature = 25.0 + i;

    data.add(TemperatureData(dateTime, temperature));
  }

  return data;
}

class TemperatureData {
  final DateTime time;
  final double temperature;

  TemperatureData(this.time, this.temperature);
}

class DataProvider with ChangeNotifier {
  List<TemperatureData> _dataList = [];
  late double _temp;

  List<TemperatureData> get dataList => _dataList;

  List<TemperatureData> _data = [];

  List<TemperatureData> get data => _data;

  double get temp => _temp;
  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://luishdez.com.mx/temperatura_sensor.php'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      _dataList = jsonData
          .map((json) => TemperatureData(
                DateTime.parse(json['created_at']),
                double.parse(json['temperatura']),
              ))
          .toList();
      _data = [
        // Agrega más datos aquí
      ];
      _dataList.forEach((data) {
        temperatureList.add(data.temperature);

        DateTime dateTime1 = data.time;

        int hour = dateTime1.hour;
        int minute = dateTime1.minute;
        int second = dateTime1.second;
        int day = dateTime1.day;
        int month = dateTime1.month;
        int year = dateTime1.year;

        DateTime dateTime = DateTime(year, month, day, hour, minute, second);
        double temperature = data.temperature;
        _temp = temperature;
        print(_temp);
        _data.add(TemperatureData(dateTime, temperature));
      });

      notifyListeners();
    } else {
      throw Exception('Error al cargar los datos');
    }
  }
}
