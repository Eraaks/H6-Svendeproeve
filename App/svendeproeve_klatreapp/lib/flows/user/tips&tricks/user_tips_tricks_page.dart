import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';

class TipsTricksPage extends StatelessWidget {
  TipsTricksPage({super.key});

  final AuthService _auth = AuthService();
  final SideMenu _sideMenu = SideMenu();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: ReusableAppBar(),
      drawer: _sideMenu,
      body: const Center(
        child: Text(
          "Empty Tricks page",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
