import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/models/problems_model.dart';

class OverviewWidgets extends StatefulWidget {
  const OverviewWidgets({Key? key}) : super(key: key);

  @override
  State<OverviewWidgets> createState() => _OverviewWidgetsState();
}

class _OverviewWidgetsState extends State<OverviewWidgets> {
  List<ProblemsModel> problemsList = getAllProblems();
  List<ClimbingAreaModel> climbingAreas = getAllClimbingAreas();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: mainBackgroundColor,
        appBar: const Topbar(),
        drawer: const Sidebar(),
        body: Center(
          child: ListView.builder(
            itemCount: climbingAreas.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  const Divider(height: 20, color: Colors.black),
                  Text(
                    climbingAreas[index].name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  DataTableBuilder(
                    problems: climbingAreas[index].problems,
                    updateState: () {
                      setState(() {});
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class DataTableBuilder extends StatelessWidget {
  final List<ProblemsModel> problems;
  final Function updateState;

  DataTableBuilder({required this.problems, required this.updateState});

  @override
  Widget build(BuildContext context) {
    int doneCount = problems
        .where((problem) => problem.isCompleted || problem.isFlashed)
        .length;
    int flashedCount = problems.where((problem) => problem.isFlashed).length;
    int totalRows = problems.length;

    return DataTable(
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
      ],
      rows: problems.map((problem) {
        return DataRow(
          cells: <DataCell>[
            DataCell(
              IconButton(
                icon: const Icon(Icons.done),
                color:
                    (problem.isCompleted == true || problem.isFlashed == true)
                        ? Colors.green
                        : null,
                onPressed: () {
                  if (problem.isFlashed == true) {
                    print('do nothing');
                  } else {
                    if (problem.isCompleted == true) {
                      if (problem.isFlashed == false) {
                        print('subtract for completed -5');
                        // points -= 5;
                      }
                    } else {
                      print('add for completed +5');
                      //  points += 5;
                    }

                    problem.isCompleted = !problem.isCompleted;
                  }

                  updateState();
                },
              ),
            ),
            DataCell(
              IconButton(
                icon: const Icon(Icons.done_all),
                color: problem.isFlashed == true ? Colors.green : null,
                onPressed: () {
                  if (problem.isFlashed == true &&
                      problem.isCompleted == false) {
                    print('subtract for flash + completed -15');
                    // points -= 15;
                  } else if (problem.isFlashed == true) {
                    print('subtract for flash - completed -10');
                    // points -= 10;
                  } else {
                    if (problem.isCompleted == true) {
                      print('added for flashed - completed + 10');
                      // points += 10;
                    } else {
                      print('added for flashed + completed + 15');
                      // points += 15;
                    }
                  }
                  problem.isFlashed = !problem.isFlashed;
                  updateState();
                },
              ),
            ),
            DataCell(
              Container(
                decoration: BoxDecoration(
                  color: problem.color,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    problem.grade,
                    style: TextStyle(
                      color:
                          problem.color == Colors.black ? Colors.white : null,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
