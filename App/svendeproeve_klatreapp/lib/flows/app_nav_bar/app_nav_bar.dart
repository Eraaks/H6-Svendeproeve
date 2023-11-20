import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_nav_bar/widgets/nav_bar_widget.dart';

class NavBarPage extends StatefulWidget {
  final String selectedGym;
  const NavBarPage({Key? key, required this.selectedGym}) : super(key: key);

  @override
  State<NavBarPage> createState() => _NavBarPageState(selectedGym: selectedGym);
}

class _NavBarPageState extends State<NavBarPage> {
  final String selectedGym;

  _NavBarPageState({required this.selectedGym});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: NavBarWidgets(selectedGym: selectedGym));
}
