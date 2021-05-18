import 'package:dashboard_covid_19/config/styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CovidBarChart extends StatelessWidget {
  final List<num> covidCases;

  const CovidBarChart({@required this.covidCases});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 410.0, // tamanho da tela do celular
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
            padding: const EdgeInsets.all(20.0), // distancia da borda branca
            alignment: Alignment.centerLeft,
            child: Text(
              'Novos Casos Diarios',
              style:
                  const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: BarChart(
              BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 16.0, // y do grafico
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                          margin: 10.0,
                          showTitles: true,
                          textStyle: Styles.chartLabelsTextStyle,
                          rotateAngle: -35.0,
                          getTitles: (double value) {
                            switch (value.toInt()) {
                              case 0:
                                return '24/05';
                              case 1:
                                return '25/05';
                              case 2:
                                return '26/05';
                              case 3:
                                return '27/05';
                              case 4:
                                return '28/05';
                              case 5:
                                return '29/05';
                              case 6:
                                return '30/05';
                              default:
                                return '';
                            }
                          }),
                      leftTitles: SideTitles(
                          margin: 10.0,
                          showTitles: true,
                          textStyle: Styles.chartLabelsTextStyle,
                          getTitles: (value) {
                            if (value == 0) {
                              return '0';
                            } else if (value % 3 == 0) {
                              return '${value ~/ 3 * 5}K';
                            }
                            return '';
                          }
                        )
                    ),
                  gridData: FlGridData(
                    show: true,
                    checkToShowHorizontalLine: (value) => value % 3 == 0,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.black12,
                      strokeWidth: 1.0,
                      dashArray: [5],
                    )
                  ),
                  borderData: FlBorderData(show: false),// tira a borda do grafico
                  barGroups: covidCases
                      .asMap()
                      .map((key, value) => MapEntry(
                            key,
                            BarChartGroupData(
                              x: key,
                              barRods: [
                                BarChartRodData(
                                  y: value,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ))
                      .values
                      .toList()),
            ),
          )
        ],
      ),
    );
  }
}
