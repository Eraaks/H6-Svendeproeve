import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_nav_bar/widgets/nav_bar_widget.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({Key? key}) : super(key: key);

  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  @override
  Widget build(BuildContext context) => const Scaffold(body: NavBarWidgets());
}
