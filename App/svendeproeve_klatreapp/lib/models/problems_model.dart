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
  bool? isFlashed;
  bool? isCompleted;

  ProblemsModel(
      {required this.grade,
      required this.color,
      this.isFlashed,
      this.isCompleted});

  ProblemsModel copy({String? grade}) => ProblemsModel(
      grade: grade ?? this.grade,
      color: color,
      isCompleted: isCompleted,
      isFlashed: isFlashed);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProblemsModel &&
          runtimeType == other.runtimeType &&
          grade == other.grade;
  @override
  int get hashCode => grade.hashCode;
}
