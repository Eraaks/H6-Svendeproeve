import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/user/rankings/widgets/user_rankings_widget.dart';

class RankingsPage extends StatefulWidget {
  const RankingsPage({Key? key}) : super(key: key);

  @override
  State<RankingsPage> createState() => _RankingsPageState();
}

class _RankingsPageState extends State<RankingsPage> {
  @override
  Widget build(BuildContext context) => const Scaffold(body: RankingsWidgets());
}
