import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/user/overview/widgets/user_overview_widget.dart';

class OverviewPage extends StatefulWidget {
  final String selectedGym;
  const OverviewPage({Key? key, required this.selectedGym}) : super(key: key);

  @override
  State<OverviewPage> createState() =>
      _OverviewPageState(selectedGym: selectedGym);
}

class _OverviewPageState extends State<OverviewPage> {
  final String selectedGym;

  _OverviewPageState({required this.selectedGym});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: OverviewWidgets(selectedGym: selectedGym));
}
