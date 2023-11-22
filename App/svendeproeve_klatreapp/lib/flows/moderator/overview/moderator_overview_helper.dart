import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/models/climbing_center.dart';
import 'package:svendeproeve_klatreapp/models/problems_model.dart';
import 'package:svendeproeve_klatreapp/models/profile_data.dart';
import 'package:svendeproeve_klatreapp/services/klatreapp_api_service.dart';

Widget areaDialog(edit, context, centerName, area, userUID) {
  TextEditingController editAreaController = TextEditingController();
  final APIService _apiService = APIService();

  Future<void> _editArea(
      centerName, climbingArea, userUID, fieldToChange, newValue) async {
    await _apiService.updateClimbingArea(
        centerName, climbingArea, userUID, fieldToChange, newValue);
  }

  // Future<void> _addArea(centerName, climbingArea, userUID, areaName) async {
  //   await _apiService.createClimbingArea(
  //       centerName, climbingArea, userUID, areaName);
  // }

  return StatefulBuilder(
    builder: (context, setState) {
      return AlertDialog(
        title: const Text('Please fill out the data:'),
        content: TextFormField(
          controller: editAreaController,
          decoration: InputDecoration(
            labelText: 'Area',
            labelStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(Icons.sync_problem, color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(width: 2, color: topBackgroundColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: topBackgroundColor),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              print('Confirmed editing');
              print(editAreaController.text);
              if (edit = true) {
                _editArea(
                    centerName, area, userUID, area, editAreaController.text);
                print('edit area');
              } else {
                // _addArea();
                print('add area');
              }
              Navigator.pop(context, editAreaController.text);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Confirm'),
          ),
          TextButton(
            onPressed: () {
              print('Cancel editing');
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}

Widget problemDialog(
    climbingArea, selectedGym, edit, selectedGrade, selectedColor, userUID) {
  final APIService _apiService = APIService();

  Future<void> _editProblem(centerName, climbingArea, userUID, route) async {
    await _apiService.updateClimbingRoute(
        centerName, climbingArea, userUID, route);
  }

  Future<void> _addProblem(
      centerName, climbingArea, userUID, problemName) async {
    await _apiService.createClimbingRoute(
        centerName, climbingArea, userUID, problemName);
  }

  TextEditingController editProblemController = TextEditingController();
  return StatefulBuilder(
    builder: (context, setState) {
      return AlertDialog(
        title: const Text('Please fill out the data:'),
        content: SizedBox(
          height: 300,
          child: Column(
            children: [
              TextFormField(
                controller: editProblemController,
                decoration: InputDecoration(
                  labelText: 'Grade',
                  labelStyle: const TextStyle(color: Colors.grey),
                  prefixIcon:
                      const Icon(Icons.sync_problem, color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide:
                        const BorderSide(width: 2, color: topBackgroundColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2, color: topBackgroundColor),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButton<String>(
                value: selectedColor,
                onChanged: (String? value) {
                  setState(() {
                    selectedColor = value!;
                  });
                },
                items: colorMap.keys.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        color: colorMap[value],
                        child: Center(
                            child: Text(
                          value,
                          style: TextStyle(
                            color: colorMap[value] == Colors.black
                                ? Colors.white
                                : null,
                          ),
                        )),
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Implement logic when Confirm is pressed
              final ProblemsModel route = ProblemsModel(
                  grade: editProblemController.text,
                  color: Color.fromARGB(255, 0, 68, 255));

              if (edit = true) {
                _editProblem(selectedGym, climbingArea, userUID, route);
                print('Edit problem');
              } else {
                _addProblem(selectedGym, climbingArea, userUID, route);
                print('Add problem');
              }

              print(editProblemController.text);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Confirm'),
          ),
          TextButton(
            onPressed: () {
              // Implement logic when Cancel is pressed
              print('Cancel editing');
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}

Widget deleteProblemDialog(problem) {
  final APIService _apiService = APIService();

  // Future<void> _deleteProblem(problemID) async {
  //   await _apiService.deleteClimbingRoute(
  //       userUID, centerName, climbingArea, problemID);
  // }

  return StatefulBuilder(
    builder: (context, setState) {
      return AlertDialog(
        title: const Text('Confirm deleting Route: ProblemID:'),
        actions: [
          TextButton(
            onPressed: () {
              print('Confirmed deleting');
              //print(problem.id);
              Navigator.pop(context); // Close the AlertDialog
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Confirm'),
          ),
          TextButton(
            onPressed: () {
              print('Cancel deleting');
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
