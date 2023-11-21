import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_nav_bar/widgets/nav_bar_widget.dart';
import 'package:svendeproeve_klatreapp/models/profile_data.dart';

class NavBarPage extends StatefulWidget {
  final String SelectedGym;
  final ProfileData profileData;
  const NavBarPage(
      {Key? key, required this.SelectedGym, required this.profileData})
      : super(key: key);

  @override
  State<NavBarPage> createState() =>
      _NavBarPageState(SelectedGym: SelectedGym, profileData: profileData);
}

class _NavBarPageState extends State<NavBarPage> {
  final String SelectedGym;
  final ProfileData profileData;

  _NavBarPageState({required this.SelectedGym, required this.profileData});
  @override
  Widget build(BuildContext context) => Scaffold(
      body: NavBarWidgets(SelectedGym: SelectedGym, profileData: profileData));
}
