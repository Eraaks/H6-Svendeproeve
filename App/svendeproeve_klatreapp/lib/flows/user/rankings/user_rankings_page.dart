import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/user/rankings/widgets/user_rankings_widget.dart';

class RankingsPage extends StatefulWidget {
  final String selectedGym;
  const RankingsPage({Key? key, required this.selectedGym}) : super(key: key);

  @override
  State<RankingsPage> createState() =>
      _RankingsPageState(selectedGym: selectedGym);
}

class _RankingsPageState extends State<RankingsPage> {
  final String selectedGym;

  _RankingsPageState({required this.selectedGym});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: RankingsWidgets(selectedGym: selectedGym));
}
