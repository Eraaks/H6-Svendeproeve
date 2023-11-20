import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/user/overview/widgets/user_overview_widget.dart';

class OverviewPage extends StatefulWidget {
  final String SelectedGym;
  const OverviewPage({Key? key, required this.SelectedGym}) : super(key: key);

  @override
  State<OverviewPage> createState() =>
      _OverviewPageState(SelectedGym: SelectedGym);
}

class _OverviewPageState extends State<OverviewPage> {
  final String SelectedGym;

  _OverviewPageState({required this.SelectedGym});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: OverviewWidgets(SelectedGym: SelectedGym));
}
