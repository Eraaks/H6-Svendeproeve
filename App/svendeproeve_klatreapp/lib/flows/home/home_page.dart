import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/home/widgets/home_widget.dart';

class HomePage extends StatefulWidget {
  final String SelectedGym;
  const HomePage({Key? key, required this.SelectedGym}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState(SelectedGym: SelectedGym);
}

class _HomePageState extends State<HomePage> {
  final String SelectedGym;
  _HomePageState({required this.SelectedGym});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: HomeWidgets(SelectedGym: SelectedGym));
}
