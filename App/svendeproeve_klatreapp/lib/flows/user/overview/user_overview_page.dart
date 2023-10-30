import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/user/overview/widgets/user_overview_widget.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) => const Scaffold(body: OverviewWidgets());
}
