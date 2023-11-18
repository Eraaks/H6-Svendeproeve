import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/flows/user/tips&tricks/widgets/user_selected_exercise_widget.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/models/exercise_model.dart';
import 'package:svendeproeve_klatreapp/services/klatreapp_api_service.dart';

class ExercisePage extends StatefulWidget {
  final ExerciseModel exercise;

  const ExercisePage({Key? key, required this.exercise}) : super(key: key);

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  static final APIService _apiService = APIService();
  Future<List<ExerciseModel>>? includedIn;

  @override
  void initState() {
    super.initState();
    includedIn =
        _apiService.getIncludedInExercises(widget.exercise.overallTarget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: const Topbar(),
      drawer: const Sidebar(),
      body: Column(
        children: [
          Container(
            color: mainBackgroundColor,
            padding: const EdgeInsets.only(top: 5, left: 15),
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
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
          FutureBuilder(
            future: includedIn,
            builder: (context, includedInSnapshot) {
              if (includedInSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (includedInSnapshot.hasError) {
                return Center(
                  child: Text('Error: ${includedInSnapshot.error}'),
                );
              } else if (includedInSnapshot.hasData) {
                final includedInList = includedInSnapshot.data;
                print(includedInList);
                return SizedBox(
                  height: 700,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(12),
                    itemCount: includedInList!.length,
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 12);
                    },
                    itemBuilder: (context, index) {
                      final exercise = includedInList[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SelectedExercisePage(exercise: exercise),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: topBackgroundColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(exercise.name),
                                        Text(exercise.benefits),
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
                );
              } else {
                return Center(
                  child: Text('Error: ${includedInSnapshot.error}'),
                );
              }
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
