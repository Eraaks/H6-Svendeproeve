import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/home/widgets/home_widget.dart';

class HomePage extends StatefulWidget {
  final String selectedGym;
  const HomePage({Key? key, required this.selectedGym}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState(selectedGym: selectedGym);
}

class _HomePageState extends State<HomePage> {
  final String selectedGym;
  _HomePageState({required this.selectedGym});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: HomeWidgets(selectedGym: selectedGym));
}
