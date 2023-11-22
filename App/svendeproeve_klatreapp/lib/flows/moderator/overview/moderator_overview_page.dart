import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/home/widgets/home_widget.dart';
import 'package:svendeproeve_klatreapp/flows/moderator/overview/widgets/moderator_overview_widget.dart';
import 'package:svendeproeve_klatreapp/models/profile_data.dart';

class ModOverviewPage extends StatefulWidget {
  final String selectedGym;
  final ProfileData profileData;
  const ModOverviewPage(
      {Key? key, required this.selectedGym, required this.profileData})
      : super(key: key);

  @override
  State<ModOverviewPage> createState() =>
      _ModOverviewPageState(selectedGym: selectedGym, profileData: profileData);
}

class _ModOverviewPageState extends State<ModOverviewPage> {
  final String selectedGym;
  final ProfileData profileData;

  _ModOverviewPageState({required this.selectedGym, required this.profileData});
  @override
  Widget build(BuildContext context) => Scaffold(
      body: ModOverviewWidgets(
          selectedGym: selectedGym, profileData: profileData));
}
