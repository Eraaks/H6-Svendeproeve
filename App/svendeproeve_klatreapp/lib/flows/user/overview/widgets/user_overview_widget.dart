import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/flows/reusable/restart_app.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/models/climbing_center.dart';
import 'package:svendeproeve_klatreapp/models/problems_model.dart';
import 'package:svendeproeve_klatreapp/services/klatreapp_api_service.dart';

class OverviewWidgets extends StatefulWidget {
  final String SelectedGym;
  const OverviewWidgets({Key? key, required this.SelectedGym})
      : super(key: key);

  @override
  State<OverviewWidgets> createState() =>
      _OverviewWidgetsState(SelectedGym: SelectedGym);
}

class _OverviewWidgetsState extends State<OverviewWidgets> {
  final String SelectedGym;
  _OverviewWidgetsState({required this.SelectedGym});
  static final APIService _apiService = APIService();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<List<Areas>>? areas;

  List<ProblemsModel> problemsList = getAllProblems();
  List<ClimbingAreaModel> climbingAreas = getAllClimbingAreas();

  @override
  void initState() {
    super.initState();
    getCenterRoutes(SelectedGym);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getCenterRoutes(String centerName) async {
    areas = _apiService.getCenterRoutes(centerName);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: mainBackgroundColor,
        appBar: const Topbar(),
        drawer: const Sidebar(),
        body: Center(
          child: FutureBuilder<List<Areas>>(
            future: areas,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final data = snapshot.data ?? <Areas>[];
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const Divider(height: 20, color: Colors.black),
                              Text(
                                data[index].name!,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              DataTableBuilder(
                                problems: data[index].areaRoutes!,
                                updateState: () {
                                  setState(() {});
                                },
                                userUID: _auth.currentUser!.uid,
                                climbingCenterName: SelectedGym,
                                areaName: data[index].name!,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const Divider(height: 20, color: Colors.black),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Submit:'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            //addRoute(grade);
                            print('Submitting');
                          },
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class DataTableBuilder extends StatelessWidget {
  final List<AreaRoutes> problems;
  final Function updateState;
  final String userUID;
  final String climbingCenterName;
  final String areaName;
  static final APIService _apiService = APIService();

  DataTableBuilder(
      {required this.problems,
      required this.updateState,
      required this.userUID,
      required this.climbingCenterName,
      required this.areaName});

  @override
  Widget build(BuildContext context) {
    int doneCount = problems
        .where((problem) =>
            problem.usersWhoCompleted!.contains(userUID) ||
            problem.usersWhoFlashed!.contains(userUID))
        .length;
    int flashedCount = problems
        .where((problem) => problem.usersWhoFlashed!.contains(userUID))
        .length;
    int totalRows = problems.length;

    return DataTable(
      columnSpacing: 20,
      columns: <DataColumn>[
        DataColumn(
          label: Text('Done $doneCount/$totalRows',
              style: const TextStyle(fontStyle: FontStyle.italic)),
        ),
        DataColumn(
          label: Text('Flashed $flashedCount/$totalRows',
              style: const TextStyle(fontStyle: FontStyle.italic)),
        ),
        const DataColumn(
          label: Text('Grade', style: TextStyle(fontStyle: FontStyle.italic)),
        ),
        const DataColumn(
          label: Text('Number', style: TextStyle(fontStyle: FontStyle.italic)),
        ),
        // const DataColumn(
        //     label:
        //         Text('Submit', style: TextStyle(fontStyle: FontStyle.italic))),
      ],
      rows: problems.map((problem) {
        final split = problem.color!.replaceAll(' ', '').split(',');
        final Map<int, String> values = {
          for (int i = 0; i < split.length; i++) i: split[i]
        };
        return DataRow(
          cells: <DataCell>[
            DataCell(
              IconButton(
                icon: const Icon(Icons.done),
                color: problem.usersWhoCompleted!.contains(userUID) ||
                        problem.usersWhoFlashed!.contains(userUID)
                    ? Colors.green
                    : null,
                onPressed: () {
                  if (problem.usersWhoCompleted!.contains(userUID)) {
                    problem.usersWhoCompleted!.remove(userUID);
                  } else {
                    problem.usersWhoCompleted!.add(userUID);
                  }
                  updateState();
                },
              ),
            ),
            DataCell(
              IconButton(
                icon: const Icon(Icons.done_all),
                color: problem.usersWhoFlashed!.contains(userUID)
                    ? Colors.green
                    : null,
                onPressed: () {
                  if (problem.usersWhoFlashed!.contains(userUID)) {
                    problem.usersWhoFlashed!.remove(userUID);
                  } else {
                    problem.usersWhoFlashed!.add(userUID);
                  }
                  updateState();
                },
              ),
            ),
            DataCell(
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(
                      int.parse(values[0]!),
                      int.parse(values[1]!),
                      int.parse(values[2]!),
                      int.parse(values[3]!)),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    problem.grade!,
                    style: TextStyle(
                      color: Color.fromARGB(
                                  int.parse(values[0]!),
                                  int.parse(values[1]!),
                                  int.parse(values[2]!),
                                  int.parse(values[3]!)) ==
                              Colors.black
                          ? Colors.white
                          : null,
                    ),
                  ),
                ),
              ),
            ),
            DataCell(
              Container(
                child: Center(
                  child: Text(
                    problem.number.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            // DataCell(
            //   Container(
            //     child: Center(
            //       child: IconButton(
            //         icon: const Icon(Icons.add),
            //         onPressed: () async {
            //           print('Submitting');
            //           if (problem.usersWhoCompleted!.contains(userUID) ||
            //               problem.usersWhoFlashed!.contains(userUID)) {
            //             await _apiService.updateRouteCompleters(
            //                 climbingCenterName,
            //                 areaName,
            //                 problem.id!,
            //                 userUID,
            //                 problem.usersWhoFlashed!.contains(userUID));

            //             await _apiService.submitUserClimb(
            //                 userUID,
            //                 climbingCenterName,
            //                 areaName,
            //                 problem.grade!.replaceAll('+', 'Plus'),
            //                 problem.usersWhoFlashed!.contains(userUID),
            //                 problem.id!);

            //             // Restart Appen
            //             RestartWidget.restartApp(context);
            //           }
            //         },
            //       ),
            //     ),
            //   ),
            // )
          ],
        );
      }).toList(),
    );
  }
}
