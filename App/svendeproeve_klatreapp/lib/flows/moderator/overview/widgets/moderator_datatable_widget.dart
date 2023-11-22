import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/moderator/overview/moderator_overview_helper.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/models/climbing_center.dart';
import 'package:svendeproeve_klatreapp/models/problems_model.dart';
import 'package:svendeproeve_klatreapp/models/profile_data.dart';

class DataTableBuilder extends StatefulWidget {
  final List<AreaRoutes> problems;
  final Function updateState;
  final String selectedGym;
  final ProfileData profileData;

  DataTableBuilder(
      {required this.problems,
      required this.updateState,
      required this.selectedGym,
      required this.profileData});

  @override
  _DataTableBuilderState createState() => _DataTableBuilderState();
}

class _DataTableBuilderState extends State<DataTableBuilder> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = 'Color red'; // Set an initial value for the dropdown
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Center(
              child:
                  Text('Edit', style: TextStyle(fontStyle: FontStyle.italic)),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(
              child:
                  Text('Delete', style: TextStyle(fontStyle: FontStyle.italic)),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(
              child:
                  Text('Grade', style: TextStyle(fontStyle: FontStyle.italic)),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Center(
              child:
                  Text('Number', style: TextStyle(fontStyle: FontStyle.italic)),
            ),
          ),
        ),
      ],
      rows: widget.problems.map((problem) {
        final split = problem.color!.replaceAll(' ', '').split(',');
        final Map<int, String> values = {
          for (int i = 0; i < split.length; i++) i: split[i]
        };
        return DataRow(
          cells: <DataCell>[
            DataCell(
              //Edit Problem
              // problemDialog(climbingArea, selectedGym, edit, selectedGrade, selectedColor)
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  var edit = true;
                  showDialog(
                    context: context,
                    builder: (_) => problemDialog(
                        'Gorilla Right',
                        widget.selectedGym,
                        edit,
                        problem.grade,
                        selectedValue,
                        widget.profileData.id),
                  );
                },
              ),
            ),
            DataCell(
              //Delete Problem
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => deleteProblemDialog(problem.id!),
                  );
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
          ],
        );
      }).toList(),
    );
  }
}
