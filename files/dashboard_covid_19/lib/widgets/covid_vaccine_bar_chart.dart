import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CovidVaccineBarChart extends StatelessWidget {
  final Map<String, num> vaccines;

  const CovidVaccineBarChart({@required this.vaccines});

  _buildChard() {
    final spotData = vaccines.values
        .toList()
        .asMap()
        .map(
          (index, value) => MapEntry(
            index,
            FlSpot(index.toDouble(), value.toDouble()),
          ),
        )
        .values
        .toList();

    return LineChart(LineChartData(
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: Colors.grey,
            fontSize: 9.0,
            fontWeight: FontWeight.w500,
          ),
          getTitles: (value) {
            formatDate(String date) {
              final splitDate = date.split('/');
              final day = splitDate[1];
              final month = splitDate[0];
              return '$day/$month';
            }

            if (value == 0) return formatDate(vaccines.keys.first);
            if (value == vaccines.length - 1)
              return formatDate(vaccines.keys.last);
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: Colors.grey,
            fontSize: 9.0,
            fontWeight: FontWeight.w500,
          ),
          interval:
              pow(10, vaccines.values.last.toString().length - 2).toDouble(),
          getTitles: (value) {
            if (value == 0) return '0';
            return '${value ~/ 1000000}K';
          },
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: spotData,
          isCurved: true,
          dotData: FlDotData(show: false),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 410.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Total de Vacinados',
              style:
                  const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: vaccines.keys.length > 0
                ? _buildChard()
                : Text(
                    "Carregando...",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
