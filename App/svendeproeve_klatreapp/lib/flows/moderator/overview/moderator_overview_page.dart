import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/home/widgets/home_widget.dart';
import 'package:svendeproeve_klatreapp/flows/moderator/overview/widgets/moderator_overview_widget.dart';

class ModOverviewPage extends StatefulWidget {
  const ModOverviewPage({Key? key}) : super(key: key);

  @override
  State<ModOverviewPage> createState() => _ModOverviewPageState();
}

class _ModOverviewPageState extends State<ModOverviewPage> {
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: ModOverviewWidgets());
}
