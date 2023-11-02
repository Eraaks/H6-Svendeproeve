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
  List<ExerciseModel> exercises = _getAllExercises();
  List<GripsModel> grips = _getAllGrips();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: reusableAppBar(),
      drawer: const Sidebar(),
      body: Column(
        children: [
          const Text(
            "Exercises",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              itemCount: exercises.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 12);
              },
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return GestureDetector(
                  onTap: () {
                    print(exercise.name);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          exercise.assetLocation,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(exercise.name),
                    ],
                  ),
                );
              },
            ),
          ),
          const Text(
            "Grips",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(12),
              itemCount: grips.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 12);
              },
              itemBuilder: (context, index) {
                final grip = grips[index];
                return GestureDetector(
                  onTap: () {
                    print(grip.name);
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          grip.img,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(grip.name),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
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
  ];
  return allExercises;
}

List<GripsModel> _getAllGrips() {
  final allGrips = [
    const GripsModel(
      name: 'Jugs',
      img:
          'https://static.wixstatic.com/media/003ebe_868ef5895e9647f78e1e816043d8da40~mv2.jpeg/v1/fill/w_640,h_640,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/003ebe_868ef5895e9647f78e1e816043d8da40~mv2.jpeg',
      description: 'Nice',
    ),
    const GripsModel(
        name: 'Pinches',
        img:
            'https://static.wixstatic.com/media/003ebe_418dcfcb31bb4375b5c4312f1922c0b4~mv2.jpeg/v1/fill/w_640,h_640,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/003ebe_418dcfcb31bb4375b5c4312f1922c0b4~mv2.jpeg',
        description: 'Alright'),
    const GripsModel(
      name: 'Crimp',
      img:
          'https://www.99boulders.com/wp-content/uploads/2018/02/crimp-climbing-hold-1200x675.png',
      description: 'Bitch',
    ),
    const GripsModel(
        name: 'Pinches',
        img:
            'https://static.wixstatic.com/media/003ebe_418dcfcb31bb4375b5c4312f1922c0b4~mv2.jpeg/v1/fill/w_640,h_640,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/003ebe_418dcfcb31bb4375b5c4312f1922c0b4~mv2.jpeg',
        description: 'Alright'),
  ];
  return allGrips;
}
