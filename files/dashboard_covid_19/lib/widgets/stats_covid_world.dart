import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CovidStatsWorld extends StatefulWidget {
  @override
  CovidStatsWorldState createState() => CovidStatsWorldState();
}

class CovidStatsWorldState extends State<CovidStatsWorld> {
  final formatter = NumberFormat("###,###.##", "pt_BR");
  num totalCases = 0;
  num totalDeaths = 0;
  num totalRecovered = 0;
  num activeCases = 0;
  num criticalCases = 0;
  bool carregado = false;

  getInfoCoronaWorld() async {
    String url = "https://corona.lmao.ninja/v2/all";
    http.Response response;
    response = await http.get(url);
    if (response.statusCode == 200) {
      var decodeJson = jsonDecode(response.body);
      return (decodeJson);
    }
  }

  @override
  void initState() {
    super.initState();
    getInfoCoronaWorld().then((map) {
      setState(() {
        totalCases = map['cases'];
        totalDeaths = map['deaths'];
        totalRecovered = map['recovered'];
        activeCases = map['active'];
        criticalCases = map['critical'];
        carregado = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(
                    'Total de Casos', formatter.format(totalCases), Colors.orange),
                _buildStatCard('Mortes', formatter.format(totalDeaths), Colors.red),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(
                    'Recuperados', formatter.format(totalRecovered), Colors.green),
                _buildStatCard(
                    'Infectados', formatter.format(activeCases), Colors.lightBlue),
                _buildStatCard(
                    'Critico', formatter.format(criticalCases), Colors.purple),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(5.2),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10.0)),
          child: carregado // msg de carregamento
              ? Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(// stilo dos titulos
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        // stilo dos dados
                        count,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  child: Text(
                  "Carregando...",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ))),
    );
  }
}
