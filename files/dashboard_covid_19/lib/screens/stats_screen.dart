import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:dashboard_covid_19/config/palette.dart';
import 'package:dashboard_covid_19/config/styles.dart';
import 'package:dashboard_covid_19/data/data.dart';
import 'package:dashboard_covid_19/widgets/stats_covid_world.dart';
import 'package:dashboard_covid_19/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  
  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Estatisticas',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
        ) 
      ),
    );
  }

  SliverToBoxAdapter _buildRegionTabBar() {
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
              Tab (text:'Brasil'),
              Tab (text:'Mundo'),
            ],
            onTap: (index) {},
          ),
        ),
      );      
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
            CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: <Widget>[
                _buildHeader(),
                _buildRegionTabBar(),
                SliverPadding(// campos coloridos
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: CovidStats(),// puxando o widget da outra pasta
                  ),
                ),
                SliverPadding(//grafico
                  padding: const EdgeInsets.only(top: 20.0),
                  sliver: SliverToBoxAdapter(
                    child: CovidBarChart(
                      covidCases: covidUSADailyNewCases),//puxando o widget e o data.dart
                  ),
                ),
              ],
            ),
      
      CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(),
          _buildRegionTabBar(),
          SliverPadding(// campos coloridos
           padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: CovidStatsWorld(),// puxando o widget da outra pasta
            ),
          ),
          SliverPadding(//grafico
            padding: const EdgeInsets.only(top: 20.0),
            sliver: SliverToBoxAdapter(
              child: CovidBarChart(
                covidCases: covidUSADailyNewCases
              ),//puxando o widget e o data.dart
            ),
          )
        ]
      )]
      )
      )
    );
  }  
}
