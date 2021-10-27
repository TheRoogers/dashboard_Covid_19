import 'dart:convert';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:dashboard_covid_19/config/palette.dart';
import 'package:dashboard_covid_19/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../config/styles.dart';
import '../widgets/widgets.dart';

class VaccineScreen extends StatefulWidget {
  @override
  _VaccineScreenState createState() => _VaccineScreenState();
}

class _VaccineScreenState extends State<VaccineScreen> {
  final formatter = NumberFormat("###,###.##", "pt_BR");

  Map<String, num> brazilChartData = {};
  Map<String, num> worldChartData = {};

  num totalBrazilVaccines = 0;
  num totalWorldVaccines = 0;

  bool loading = true;

  getVaccinesData() async {
    http.Response brazilResponse = await http
        .get('https://disease.sh/v3/covid-19/vaccine/coverage/countries/bra');

    http.Response worldResponse =
        await http.get('https://disease.sh/v3/covid-19/vaccine/coverage');

    final parsedBrazilResponse = jsonDecode(brazilResponse.body)['timeline'];
    final parsedWorldResponse = jsonDecode(worldResponse.body);

    return {
      'brazil': new Map<String, num>.from(parsedBrazilResponse),
      'world': new Map<String, num>.from(parsedWorldResponse),
    };
  }

  @override
  void initState() {
    super.initState();
    getVaccinesData().then((response) {
      setState(() {
        totalBrazilVaccines = response['brazil'].values.last;
        brazilChartData = response['brazil'];

        totalWorldVaccines = response['world'].values.last;
        worldChartData = response['world'];

        loading = false;
      });
    });
  }

  _buildheader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Vacinômetro',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }

  _buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: TabBar(
          indicator: BubbleTabIndicator(
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
            indicatorHeight: 40.0,
            indicatorColor: Colors.white,
          ),
          labelStyle: Styles.tabTextStyle,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white,
          tabs: <Widget>[
            Tab(text: 'Brasil'),
            Tab(text: 'Mundo'),
          ],
          onTap: (index) {},
        ),
      ),
    );
  }

  _buildTabContent(total, chartData) {
    return CustomScrollView(physics: ClampingScrollPhysics(), slivers: <Widget>[
      _buildheader(),
      _buildRegionTabBar(),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        sliver: SliverToBoxAdapter(
          child: Expanded(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(5.2),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Total vacinados',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      total,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.only(top: 20.0),
        sliver: SliverToBoxAdapter(
            child: CovidVaccineBarChart(
          vaccines: chartData,
        )),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: CustomAppBar(),
      body: DefaultTabController(
        length: 2,
        child: TabBarView(
          children: [
            _buildTabContent(
                formatter.format(totalBrazilVaccines), brazilChartData),
            _buildTabContent(
                formatter.format(totalWorldVaccines), worldChartData),
          ],
        ),
      ),
    );
  }
}
