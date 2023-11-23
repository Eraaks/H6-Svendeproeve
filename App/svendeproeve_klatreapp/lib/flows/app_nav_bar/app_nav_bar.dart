import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_nav_bar/widgets/nav_bar_widget.dart';
import 'package:svendeproeve_klatreapp/models/profile_data.dart';

class NavBarPage extends StatefulWidget {
  final String selectedGym;
  final ProfileData profileData;
  final bool isModerator;
  const NavBarPage(
      {Key? key,
      required this.selectedGym,
      required this.profileData,
      required this.isModerator})
      : super(key: key);

  @override
  State<NavBarPage> createState() => _NavBarPageState(
      selectedGym: selectedGym,
      profileData: profileData,
      isModerator: isModerator);
}

class _NavBarPageState extends State<NavBarPage> {
  final String selectedGym;
  final ProfileData profileData;
  final bool isModerator;

  _NavBarPageState(
      {required this.selectedGym,
      required this.profileData,
      required this.isModerator});
  @override
  Widget build(BuildContext context) => Scaffold(
      body: NavBarWidgets(
          selectedGym: selectedGym,
          profileData: profileData,
          isModerator: isModerator));
}
