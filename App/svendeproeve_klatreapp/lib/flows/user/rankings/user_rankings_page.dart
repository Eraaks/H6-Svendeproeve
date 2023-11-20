import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/user/rankings/widgets/user_rankings_widget.dart';

class RankingsPage extends StatefulWidget {
  final String SelectedGym;
  const RankingsPage({Key? key, required this.SelectedGym}) : super(key: key);

  @override
  State<RankingsPage> createState() =>
      _RankingsPageState(SelectedGym: SelectedGym);
}

class _RankingsPageState extends State<RankingsPage> {
  final String SelectedGym;

  _RankingsPageState({required this.SelectedGym});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: RankingsWidgets(SelectedGym: SelectedGym));
}
