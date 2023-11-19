import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/flows/moderator/overview/widgets/moderator_dialog_widget.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/models/problems_model.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';

class ModOverviewWidgets extends StatefulWidget {
  const ModOverviewWidgets({Key? key}) : super(key: key);

  @override
  State<ModOverviewWidgets> createState() => _ModOverviewWidgetsState();
}

class _ModOverviewWidgetsState extends State<ModOverviewWidgets> {
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
          child: Column(
            children: [
              const Text(
                'Beta Boulders South',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: climbingAreas.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const Divider(height: 20, color: Colors.black),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              climbingAreas[index].name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                //editArea(name);
                                print('edit area');
                              },
                            ),
                          ],
                        ),
                        DataTableBuilder(
                          problems: climbingAreas[index].problems,
                          updateState: () {
                            setState(() {});
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Add Route:'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                //addRoute(grade);
                                print('add problem');
                              },
                            ),
                          ],
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
                  Text('Add Area:'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      //addRoute(grade);
                      print('add area');
                    },
                  ),
                ],
              ),
            ],
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
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
            label: Expanded(
                child: Center(
          child: Text('Edit', style: TextStyle(fontStyle: FontStyle.italic)),
        ))),
        DataColumn(
            label: Expanded(
                child: Center(
          child: Text('Delete', style: TextStyle(fontStyle: FontStyle.italic)),
        ))),
        DataColumn(
            label: Expanded(
                child: Center(
          child: Text('Grade', style: TextStyle(fontStyle: FontStyle.italic)),
        ))),
      ],
      rows: problems.map((problem) {
        return DataRow(
          cells: <DataCell>[
            DataCell(
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  //editGrade(problem);
                  print('edit problem');
                },
              ),
            ),
            DataCell(
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  print('delete problem');
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
