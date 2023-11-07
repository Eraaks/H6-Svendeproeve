import 'package:flutter/material.dart';

class ClimbingAreaModel {
  final String name;
  final List<ProblemsModel> problems;

  ClimbingAreaModel({
    required this.name,
    required this.problems,
  });
}

class ProblemsModel {
  final String grade;
  Color color;
  bool isFlashed;
  bool isCompleted;

  ProblemsModel(
      {required this.grade,
      required this.color,
      required this.isFlashed,
      required this.isCompleted});
}

List<ClimbingAreaModel> getAllClimbingAreas() {
  List<ProblemsModel> problemsList = getAllProblems();
  final areaList = [
    ClimbingAreaModel(
      name: 'Ship',
      problems: problemsList,
    ),
    ClimbingAreaModel(
      name: 'Tornado',
      problems: problemsList,
    ),
    ClimbingAreaModel(
      name: 'Gorilla',
      problems: problemsList,
    ),
  ];
  return areaList;
}

List<ProblemsModel> getAllProblems() {
  final problemsList = [
    ProblemsModel(
        grade: '6a',
        color: const Color.fromARGB(255, 41, 255, 48),
        isFlashed: false,
        isCompleted: true),
    ProblemsModel(
        grade: '6c',
        color: Color.fromARGB(255, 255, 41, 41),
        isFlashed: true,
        isCompleted: false),
    ProblemsModel(
        grade: '7a+',
        color: Color.fromARGB(255, 0, 0, 0),
        isFlashed: true,
        isCompleted: true),
    ProblemsModel(
        grade: '7a+',
        color: Color.fromARGB(255, 0, 0, 0),
        isFlashed: true,
        isCompleted: true),
    ProblemsModel(
        grade: '7a+',
        color: Color.fromARGB(255, 0, 0, 0),
        isFlashed: false,
        isCompleted: false),
  ];
  return problemsList;
}
