import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/flows/user/tips&tricks/widgets/user_exercises.widget.dart';
import 'package:svendeproeve_klatreapp/flows/user/tips&tricks/widgets/user_grips_widget.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/models/exercise_model.dart';
import 'package:svendeproeve_klatreapp/models/grips_model.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';
import 'package:svendeproeve_klatreapp/services/klatreapp_api_service.dart';

class TipsTricksWidgets extends StatefulWidget {
  const TipsTricksWidgets({Key? key}) : super(key: key);

  @override
  State<TipsTricksWidgets> createState() => _TipsTricksWidgetsState();
}

class _TipsTricksWidgetsState extends State<TipsTricksWidgets> {
  static final APIService _apiService = APIService();
  late Future<List<ExerciseModel>> exercises;
  // List<ExerciseModel> exercises = getAllExercises();
  late Future<List<GripsModel>> grips;

  @override
  void initState() {
    super.initState();
    grips = _apiService.getAllGrips();
    exercises = _apiService.getAllExercises();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: reusableAppBar(),
      drawer: const Sidebar(),
      body: Column(
        children: [
          const Text(
            "Muscle Groups",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          FutureBuilder<List<ExerciseModel>>(
            future:
                exercises, // Assuming 'exercises' is a Future that retrieves a list of ExerciseModel objects
            builder: (context, exerciseSnapshot) {
              if (exerciseSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child:
                      CircularProgressIndicator(), // Loading indicator in the center.
                );
              } else if (exerciseSnapshot.hasError) {
                return Center(
                  child: Text(
                      'Error: ${exerciseSnapshot.error}'), // Handle error state in the center.
                );
              } else {
                final exerciseList = exerciseSnapshot.data;
                return SizedBox(
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(12),
                    itemCount: exerciseList!.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 12);
                    },
                    itemBuilder: (context, index) {
                      final exercise = exerciseList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ExercisePage(exercise: exercise),
                            ),
                          );
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
                );
              }
            },
          ),
          const Text(
            "Grips",
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          FutureBuilder<List<GripsModel>>(
            future:
                grips, // Assuming 'grips' is a Future that retrieves a list of GripsModel objects
            builder: (context, gripSnapshot) {
              if (gripSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child:
                        CircularProgressIndicator() // Loading indicator in the center.
                    );
              } else if (gripSnapshot.hasError) {
                return Center(
                    child: Text(
                        'Error: ${gripSnapshot.error}') // Handle error state in the center.
                    );
              } else {
                final gripList = gripSnapshot.data;
                return SizedBox(
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(12),
                    itemCount: gripList!.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 12);
                    },
                    itemBuilder: (context, index) {
                      final grip = gripList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GripPage(grip: grip),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                grip.gripImg,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(grip.gripName),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
