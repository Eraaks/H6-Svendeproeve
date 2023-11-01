import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/models/exercise_model.dart';
import 'package:svendeproeve_klatreapp/models/grips_model.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';

final AuthService _auth = AuthService();

class TipsTricksWidgets extends StatefulWidget {
  const TipsTricksWidgets({Key? key}) : super(key: key);

  @override
  State<TipsTricksWidgets> createState() => _TipsTricksWidgetsState();
}

class _TipsTricksWidgetsState extends State<TipsTricksWidgets> {
  List<ExerciseModel> excercises = _getAllExercises();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: reusableAppBar(),
      drawer: const Sidebar(),
      body: Center(
        child: Wrap(
          runSpacing: 8,
          children: [
            const Text(
              "Empty Tricks page",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: excercises.length,
              itemBuilder: (context, index) {
                final excercise = excercises[index];
                return ListTile(
                    leading: Image.network(
                      excercise.assetLocation,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 100,
                    ),
                    title: Text(excercise.name),
                    subtitle: Text(excercise.primaryActivation),
                    onTap: () {});
              },
            ),
          ],
        ),
      ),
    );
  }

  void searchCenter(String query) {
    final suggestions = _getAllExercises().where((exercise) {
      final excerciseName = exercise.name.toLowerCase();
      final input = query.toLowerCase();

      return excerciseName.contains(input);
    }).toList();

    setState(() => excercises = suggestions);
  }
}

List<ExerciseModel> _getAllExercises() {
  final allExercises = [
    const ExerciseModel(
      name: 'Pullups',
      assetLocation: 'https://i.stack.imgur.com/AY9Xl.png',
      benefits: '',
      includedIn: '',
      overallTarget: '',
      primaryActivation: 'ur',
      secondaryActivation: '',
      reps: 0,
      sets: 0,
      howTo: null,
    ),
    const ExerciseModel(
      name: 'Lunges',
      assetLocation:
          'https://www.inspireusafoundation.org/wp-content/uploads/2023/07/bodyweight-forward-lunge.gif',
      benefits: '',
      includedIn: '',
      overallTarget: '',
      primaryActivation: 'mum',
      secondaryActivation: '',
      reps: 0,
      sets: 0,
      howTo: null,
    ),
    const ExerciseModel(
      name: 'Test',
      assetLocation:
          'https://fitnessprogramer.com/wp-content/uploads/2022/08/how-to-do-pull-up.gif',
      benefits: '',
      includedIn: '',
      overallTarget: '',
      primaryActivation: 'mate',
      secondaryActivation: '',
      reps: 0,
      sets: 0,
      howTo: null,
    ),
  ];
  return allExercises;
}

// List<GripsModel> _getAllGrips() {
//   final allClimbingCenters = [
//     const ClimbingCenter(country: 'Denmark', place: 'Beta Boulders'),
//     const ClimbingCenter(country: 'Denmark', place: 'Boulders Syd')
//   ];
//   return allClimbingCenters;
// }
