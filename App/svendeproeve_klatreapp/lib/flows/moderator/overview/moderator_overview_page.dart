import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/home/widgets/home_widget.dart';
import 'package:svendeproeve_klatreapp/flows/moderator/overview/widgets/moderator_overview_widget.dart';

class ModOverviewPage extends StatefulWidget {
  final String selectedGym;
  const ModOverviewPage({Key? key, required this.selectedGym})
      : super(key: key);

  @override
  State<ModOverviewPage> createState() =>
      _ModOverviewPageState(selectedGym: selectedGym);
}

class _ModOverviewPageState extends State<ModOverviewPage> {
  final String selectedGym;

  _ModOverviewPageState({required this.selectedGym});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: ModOverviewWidgets(selectedGym: selectedGym));
}
