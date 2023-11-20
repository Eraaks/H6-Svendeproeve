import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/flows/reusable/reusable_graph_widget.dart';
import 'package:svendeproeve_klatreapp/models/profile_data.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';
import 'package:svendeproeve_klatreapp/services/klatreapp_api_service.dart';

final Sidebar _Sidebar = Sidebar();

class PersonalWidgets extends StatefulWidget {
  final String SelectedGym;
  const PersonalWidgets({Key? key, required this.SelectedGym})
      : super(key: key);

  @override
  State<PersonalWidgets> createState() =>
      _PersonalWidgetsState(SelectedGym: SelectedGym);
}

class _PersonalWidgetsState extends State<PersonalWidgets> {
  final String SelectedGym;
  _PersonalWidgetsState({required this.SelectedGym});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: const Topbar(),
      drawer: _Sidebar,
      body: Center(
          child: Column(
        children: [
          Text('Overview for $SelectedGym'),
          Reusable_Graph_Widget(
            userUID: FirebaseAuth.instance.currentUser!.uid,
          )
        ],
      )),
    );
  }
}
