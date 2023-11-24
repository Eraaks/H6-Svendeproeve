import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/reusable/restart_app.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/models/climbing_center.dart';
import 'package:svendeproeve_klatreapp/services/klatreapp_api_service.dart';

Widget areaDialog(edit, context, centerName, area, userUID) {
  TextEditingController areaController = TextEditingController();
  // ignore: no_leading_underscores_for_local_identifiers
  final APIService _apiService = APIService();

  // ignore: no_leading_underscores_for_local_identifiers
  Future<void> _editArea(centerName, climbingArea, userUID, newValue) async {
    await _apiService.updateClimbingArea(
        centerName, climbingArea, userUID, newValue);
  }

  // ignore: no_leading_underscores_for_local_identifiers
  Future<void> _addArea(centerName, userUID, newArea) async {
    await _apiService.addClimbingAreas(centerName, userUID.id, newArea);
  }

  return StatefulBuilder(
    builder: (context, setState) {
      return AlertDialog(
        title: const Text('Please fill out the data:'),
        content: TextFormField(
          controller: areaController,
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
            onPressed: () async {
              if (edit == true) {
                _editArea(centerName, area, userUID, areaController.text);
              } else {
                AreaRoutes areaRoutes = AreaRoutes(
                  id: 'string',
                  color: 'Yellow',
                  grade: "6A",
                  usersWhoCompleted: ["string"],
                  usersWhoFlashed: ["string"],
                  number: 0,
                  assignedArea: 'string',
                );
                List<AreaRoutes> route = [];
                route.add(areaRoutes);
                Areas newArea = Areas(
                  name: areaController.text,
                  description: '',
                  areaRoutes: route,
                );
                List<Areas> newAreas = [];
                newAreas.add(newArea);
                _addArea(
                  centerName,
                  userUID,
                  newAreas,
                );
              }
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text("Loading..."),
                      ],
                    ),
                  );
                },
              );
              await Future.delayed(const Duration(seconds: 5));
              RestartWidget.restartApp(context);
              Navigator.pop(context, areaController.text);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Confirm'),
          ),
          TextButton(
            onPressed: () {
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
    climbingArea, selectedGym, edit, problem, selectedColor, userUID) {
  final APIService _apiService = APIService();

  Future<void> _editProblem(centerName, climbingArea, userUID, route) async {
    await _apiService.updateClimbingRoute(
        centerName, climbingArea, userUID, route);
  }

  Future<void> _addProblem(centerName, climbingArea, userUID, problem) async {
    await _apiService.createClimbingRoute(
        centerName, climbingArea, userUID, problem, true);
  }

  TextEditingController problemController = TextEditingController();
  return StatefulBuilder(
    builder: (context, setState) {
      return AlertDialog(
        title: const Text('Please fill out the data:'),
        content: SizedBox(
          height: 300,
          child: Column(
            children: [
              TextFormField(
                controller: problemController,
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
                          ),
                        ),
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
              if (edit == true) {
                final AreaRoutes route = AreaRoutes(
                  id: problem.id,
                  color: selectedColor,
                  grade: problemController.text,
                  usersWhoCompleted: ['string'],
                  usersWhoFlashed: ['string'],
                  number: problem.number,
                  assignedArea: climbingArea,
                );
                _editProblem(selectedGym, climbingArea, userUID, route);
              } else {
                AreaRoutes areaRoutes = AreaRoutes(
                  id: 'string',
                  color: selectedColor,
                  grade: problemController.text,
                  usersWhoCompleted: ["string"],
                  usersWhoFlashed: ["string"],
                  number: 0,
                  assignedArea: climbingArea,
                );
                List<AreaRoutes> route = [];
                route.add(areaRoutes);
                _addProblem(selectedGym, climbingArea, userUID, route);
              }
              RestartWidget.restartApp(context);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Confirm'),
          ),
          TextButton(
            onPressed: () {
              // Cancel pops alertdialog
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

Widget deleteProblemDialog(climbingArea, selectedGym, problem, userUID) {
  final APIService _apiService = APIService();

  Future<void> _deleteProblem(problemID) async {
    await _apiService.deleteClimbingRoute(
        userUID, selectedGym, climbingArea, problemID);
  }

  return StatefulBuilder(
    builder: (context, setState) {
      return AlertDialog(
        title: const Text('Confirm deleting Route: ProblemID:'),
        actions: [
          TextButton(
            onPressed: () {
              _deleteProblem(problem);
              RestartWidget.restartApp(context);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            child: const Text('Confirm'),
          ),
          TextButton(
            onPressed: () {
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
