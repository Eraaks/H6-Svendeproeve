import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_nav_bar/widgets/nav_bar_widget.dart';

class NavBarPage extends StatefulWidget {
  final String SelectedGym;
  const NavBarPage({Key? key, required this.SelectedGym}) : super(key: key);

  @override
  State<NavBarPage> createState() => _NavBarPageState(SelectedGym: SelectedGym);
}

class _NavBarPageState extends State<NavBarPage> {
  final String SelectedGym;

  _NavBarPageState({required this.SelectedGym});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: NavBarWidgets(SelectedGym: SelectedGym));
}
