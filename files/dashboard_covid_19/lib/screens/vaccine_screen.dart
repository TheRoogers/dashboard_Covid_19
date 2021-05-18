import 'package:dashboard_covid_19/config/palette.dart';
import 'package:dashboard_covid_19/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class VaccineScreen extends StatefulWidget {
  @override
  _VaccineScreenState createState() => _VaccineScreenState();
}

class _VaccineScreenState extends State<VaccineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildheader(),
          //_buildvaccinebrasil(),
          //_buildvaccineworld()
        ],
      ),
    );
  }

  SliverPadding _buildheader() {
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
}
