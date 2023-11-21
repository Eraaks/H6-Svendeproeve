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
  final ProfileData profileData;
  const PersonalWidgets(
      {Key? key, required this.SelectedGym, required this.profileData})
      : super(key: key);

  @override
  State<PersonalWidgets> createState() =>
      _PersonalWidgetsState(SelectedGym: SelectedGym, profileData: profileData);
}

class _PersonalWidgetsState extends State<PersonalWidgets> {
  final String SelectedGym;
  final ProfileData profileData;
  _PersonalWidgetsState({required this.SelectedGym, required this.profileData});
  late String? estimatedGrade = profileData.climbingHistory!
      .where((element) => element.location == SelectedGym)
      .first
      .estimatedGrade;
  late List<SendCollections> sendCollections = profileData.climbingHistory!
      .where((element) => element.location == SelectedGym)
      .first
      .sendCollections!
      .getRange(0, 9)
      .toList()
    ..sort((a, b) => a.sendDate!.compareTo(b.sendDate!));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: const Topbar(),
      drawer: _Sidebar,
      body: Center(
          child: Column(
        children: [
          Text('Overview for $selectedGym'),
          Reusable_Graph_Widget(
            userUID: FirebaseAuth.instance.currentUser!.uid,
            selectedGym: SelectedGym,
          ),
          SizedBox(
            height: 20,
          ),
          Text('Estimated Grade: $estimatedGrade'),
          SizedBox(
            height: 20,
          ),
          DataTable(
            columnSpacing: 20,
            columns: <DataColumn>[
              DataColumn(
                label: Text('Area',
                    style: const TextStyle(fontStyle: FontStyle.italic)),
              ),
              DataColumn(label: Text('Grade')),
              DataColumn(label: Text('Type Send')),
              // const DataColumn(
              //     label:
              //         Text('Submit', style: TextStyle(fontStyle: FontStyle.italic))),
            ],
            rows: sendCollections.map((sends) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(
                    Text(sends.area!),
                  ),
                  DataCell(
                    Text(sends.grade!),
                  ),
                  DataCell(
                    Text(sends.tries == 1 ? 'Flash' : 'Redpoint'),
                  ),
                ],
              );
            }).toList(),
          )
        ],
      )),
    );
  }
}
