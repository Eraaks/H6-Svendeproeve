import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/flows/reusable/reusable_graph_widget.dart';
import 'package:svendeproeve_klatreapp/models/profile_data.dart';

class PersonalWidgets extends StatefulWidget {
  final String selectedGym;
  final ProfileData profileData;
  const PersonalWidgets(
      {Key? key, required this.selectedGym, required this.profileData})
      : super(key: key);

  @override
  State<PersonalWidgets> createState() =>
      _PersonalWidgetsState(selectedGym: selectedGym, profileData: profileData);
}

class _PersonalWidgetsState extends State<PersonalWidgets> {
  final String selectedGym;
  final ProfileData profileData;
  _PersonalWidgetsState({required this.selectedGym, required this.profileData});
  late String? estimatedGrade = profileData.climbingHistory!
      .where((element) => element.location == selectedGym)
      .first
      .estimatedGrade;
  late List<SendCollections> sendCollections = profileData.climbingHistory!
      .where((element) => element.location == selectedGym)
      .first
      .sendCollections!
      .getRange(
          0,
          profileData.climbingHistory!
              .where((element) => element.location == selectedGym)
              .first
              .sendCollections!
              .length)
      .toList()
    ..sort((a, b) => a.sendDate!.compareTo(b.sendDate!));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: const Topbar(),
      drawer: const Sidebar(),
      body: Center(
          child: Column(
        children: [
          Text('Overview for $selectedGym'),
          Text('Username: ${profileData.userName}'),
          ReusableGraphWidget(
            userUID: FirebaseAuth.instance.currentUser!.uid,
            selectedGym: selectedGym,
          ),
          const SizedBox(
            height: 20,
          ),
          Text('Estimated Grade: $estimatedGrade'),
          const SizedBox(
            height: 20,
          ),
          DataTable(
            columnSpacing: 20,
            columns: const <DataColumn>[
              DataColumn(
                label:
                    Text('Area', style: TextStyle(fontStyle: FontStyle.italic)),
              ),
              DataColumn(label: Text('Grade')),
              DataColumn(label: Text('Type Send')),
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
