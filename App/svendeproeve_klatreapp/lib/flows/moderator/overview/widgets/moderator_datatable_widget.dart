import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/moderator/overview/moderator_overview_helper.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/models/problems_model.dart';

class DataTableBuilder extends StatefulWidget {
  final List<ProblemsModel> problems;
  final Function updateState;

  DataTableBuilder({required this.problems, required this.updateState});

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
      rows: widget.problems.map((problem) {
        return DataRow(
          cells: <DataCell>[
            DataCell(
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  //        _apiService.updateClimbingRoute(_auth.currentUser!.uid, this.climbingAreaName, this.climbingArea, this.problem);
                  showDialog(
                      context: context,
                      builder: (_) => routeDialog(selectedValue));
                },
              ),
            ),
            DataCell(
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => deleteDialog(),
                  );
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
