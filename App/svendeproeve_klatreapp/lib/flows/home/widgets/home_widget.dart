import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';

class HomeWidgets extends StatefulWidget {
  final String SelectedGym;
  const HomeWidgets({Key? key, required this.SelectedGym}) : super(key: key);

  @override
  State<HomeWidgets> createState() =>
      _HomeWidgetsState(SelectedGym: SelectedGym);
}

class _HomeWidgetsState extends State<HomeWidgets> {
  final String SelectedGym;
  _HomeWidgetsState({required this.SelectedGym});

  var selectedClimbingPlace = 'Please Select Climbing Place';
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: const Topbar(),
      drawer: const Sidebar(),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              SelectedGym,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
