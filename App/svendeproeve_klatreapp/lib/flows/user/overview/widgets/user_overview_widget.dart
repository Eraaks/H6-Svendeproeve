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
  final String selectedGym;
  const OverviewWidgets({Key? key, required this.selectedGym})
      : super(key: key);

  @override
  State<OverviewWidgets> createState() =>
      _OverviewWidgetsState(selectedGym: selectedGym);
}

class _OverviewWidgetsState extends State<OverviewWidgets> {
  final String selectedGym;
  _OverviewWidgetsState({required this.selectedGym});
  static final APIService _apiService = APIService();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<List<Areas>?>? areas;
  List<AreaRoutes> routesAffected = [];

  @override
  void initState() {
    super.initState();
    getCenterRoutes(selectedGym);
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
          child: FutureBuilder<List<Areas>?>(
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
                                climbingCenterName: selectedGym,
                                areaName: data[index].name!,
                                routesAffected: routesAffected,
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
                          onPressed: () async {
                            print('Submitting');
                            await _apiService.updateRouteCompleters(
                                routesAffected,
                                selectedGym,
                                _auth.currentUser!.uid);

                            await _apiService.submitUserClimb(routesAffected,
                                _auth.currentUser!.uid, selectedGym);

                            // Restart Appen
                            RestartWidget.restartApp(context);
                            //addRoute(grade);
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

class DataTableBuilder extends StatefulWidget {
  final List<AreaRoutes> problems;
  final Function updateState;
  final String userUID;
  final String climbingCenterName;
  final String areaName;
  final List<AreaRoutes> routesAffected;
  const DataTableBuilder(
      {super.key,
      required this.problems,
      required this.updateState,
      required this.userUID,
      required this.climbingCenterName,
      required this.areaName,
      required this.routesAffected});

  @override
  State<DataTableBuilder> createState() => _DataTableBuilderState(
      problems: problems,
      updateState: updateState,
      userUID: userUID,
      climbingCenterName: climbingCenterName,
      areaName: areaName,
      routesAffected: routesAffected);
}

class _DataTableBuilderState extends State<DataTableBuilder> {
  final List<AreaRoutes> problems;
  final Function updateState;
  final String userUID;
  final String climbingCenterName;
  final String areaName;
  final List<AreaRoutes> routesAffected;
  _DataTableBuilderState(
      {required this.problems,
      required this.updateState,
      required this.userUID,
      required this.climbingCenterName,
      required this.areaName,
      required this.routesAffected});

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

                  setState(() {
                    AreaRoutes test = new AreaRoutes(
                      id: problem.id,
                      color: problem.color,
                      grade: problem.grade,
                      usersWhoCompleted: problem.usersWhoCompleted,
                      usersWhoFlashed: problem.usersWhoFlashed,
                      number: problem.number,
                      assignedArea: problem.assignedArea,
                    );
                    routesAffected.add(test);
                  });
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
                onPressed: () async {
                  if (problem.usersWhoFlashed!.contains(userUID)) {
                    problem.usersWhoFlashed!.remove(userUID);
                  } else {
                    problem.usersWhoFlashed!.add(userUID);
                  }

                  setState(() {
                    AreaRoutes test = new AreaRoutes(
                      id: problem.id,
                      color: problem.color,
                      grade: problem.grade,
                      usersWhoCompleted: problem.usersWhoCompleted,
                      usersWhoFlashed: problem.usersWhoFlashed,
                      number: problem.number,
                      assignedArea: problem.assignedArea,
                    );
                    routesAffected.add(test);
                  });
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
