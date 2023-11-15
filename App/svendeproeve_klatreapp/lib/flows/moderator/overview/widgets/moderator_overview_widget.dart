import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';

final AuthService _auth = AuthService();
final Sidebar _Sidebar = Sidebar();

class ModOverviewWidgets extends StatefulWidget {
  const ModOverviewWidgets({Key? key}) : super(key: key);

  @override
  State<ModOverviewWidgets> createState() => _ModOverviewWidgetsState();
}

class _ModOverviewWidgetsState extends State<ModOverviewWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: const Topbar(),
      drawer: _Sidebar,
      body: const Center(
        child: Text(
          "Empty ModOverview Page",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
