import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/models/exercise_model.dart';

class ExercisePage extends StatefulWidget {
  final ExerciseModel exercise;

  ExercisePage({Key? key, required this.exercise}) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  List<ExerciseModel> exercises = getAllExercises();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: reusableAppBar(),
      drawer: const Sidebar(),
      body: Column(
        children: [
          Container(
            color: mainBackgroundColor,
            padding: const EdgeInsets.only(top: 5, left: 15),
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back,
                size: 26,
                color: topBackgroundColor,
              ),
            ),
          ),
          const Text(
            "Exercises",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 700,
            child: ListView.separated(
              scrollDirection: Axis.vertical,
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(
                            3), // Adjust the padding value as needed
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: topBackgroundColor, // Border color
                              width: 2, // Border width
                            ),
                            borderRadius: BorderRadius.circular(
                                15), // Border radius for the entire row
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    exercise.assetLocation,
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Align text to the beginning
                                children: [
                                  Text(exercise.name),
                                  Text(exercise.primaryActivation),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
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
