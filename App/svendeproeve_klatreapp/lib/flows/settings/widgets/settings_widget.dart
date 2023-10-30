import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';

final AuthService _auth = AuthService();
final Sidebar _Sidebar = Sidebar();

class SettingsWidgets extends StatefulWidget {
  const SettingsWidgets({Key? key}) : super(key: key);

  @override
  State<SettingsWidgets> createState() => _SettingsWidgetsState();
}

class _SettingsWidgetsState extends State<SettingsWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: reusableAppBar(),
      drawer: _Sidebar,
      body: const Center(
        child: Text(
          "Empty Settings Page",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
