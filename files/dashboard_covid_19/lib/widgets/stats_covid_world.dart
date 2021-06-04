import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

  class CovidStatsWorld extends StatefulWidget {
    @override
    CovidStatsWorldState createState() => CovidStatsWorldState();
  }
  
  class CovidStatsWorldState extends State<CovidStatsWorld> {
  int totalCases;
  int totalDeaths;
  int totalRecovered;
  int activeCases;
  int criticalCases;
  bool carregado = false;

  getInfoCoronaWorld() async {
    String url = "https://api.quarantine.country/api/v1/summary/latest";
    http.Response response;
    response = await http.get(url);
    if (response.statusCode == 200) {
      var decodeJson = jsonDecode(response.body);
      return (decodeJson['data']['summary']);
    }
  }

  @override
  void initState() {
    super.initState();
    getInfoCoronaWorld().then((map) {
      setState(() {
        totalCases = map['total_cases'];
        totalDeaths = map['deaths'];
        totalRecovered = map['recovered'];
        activeCases = map['active_cases'];
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
                 _buildStatCard('Total de Casos', totalCases.toString(), Colors.orange),
                  _buildStatCard('Mortes', totalDeaths.toString(), Colors.red),
                ],
              ),
            ),
            Flexible(
              child: Row(
                children: <Widget>[
                 _buildStatCard('Recuperados', totalRecovered.toString(), Colors.green),
                  _buildStatCard('Infectados', activeCases.toString(), Colors.lightBlue),
                  _buildStatCard('Critico', criticalCases.toString(), Colors.purple),
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
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10.0)),
            child: carregado// msg de carregamento
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
                  Text( // stilo dos dados
                    count,
                    style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,                
                    ),
                  ),
                ],
              ),
            )
            : Container(
                child: Text("Carregando...",
                  style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold
                  ),
                )
              )
      ),
    );
  }
  }