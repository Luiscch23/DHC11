import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../services/services.dart';

charts.Series<TemperatureData, DateTime> createChartSeries(
    List<TemperatureData> data) {
  return charts.Series<TemperatureData, DateTime>(
    id: 'Temperature',
    colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
    domainFn: (TemperatureData tempData, _) => tempData.time,
    measureFn: (TemperatureData tempData, _) => tempData.temperature,
    data: data,
  );
}

Widget buildChart(List<TemperatureData> data) {
  final series = createChartSeries(data);

  return charts.TimeSeriesChart(
    [series],
    animate: true,
    dateTimeFactory: const charts.LocalDateTimeFactory(),
    domainAxis: charts.DateTimeAxisSpec(
      tickProviderSpec: charts.AutoDateTimeTickProviderSpec(),
      renderSpec: charts.SmallTickRendererSpec(),
      showAxisLine: true,
      // Autoajusta la escala del eje X
    ),
    primaryMeasureAxis: charts.NumericAxisSpec(
      tickProviderSpec: charts.BasicNumericTickProviderSpec(
        desiredTickCount: 50,
      ),
      renderSpec: charts.GridlineRendererSpec(
        labelStyle: charts.TextStyleSpec(
          fontSize: 12,
          color: charts.MaterialPalette.gray.shade800,
        ),
      ),
      viewport:
          charts.NumericExtents(25, 38), // Establece el rango máximo en 20
    ),
  );
}
