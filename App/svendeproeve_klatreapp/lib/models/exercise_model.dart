class ExerciseModel {
  final String name;
  final String assetLocation;
  final String benefits;
  final String includedIn;
  final String overallTarget;
  final String primaryActivation;
  final String secondaryActivation;
  final int reps;
  final int sets;
  final HowTo? howTo;

  const ExerciseModel({
    required this.name,
    required this.assetLocation,
    required this.benefits,
    required this.includedIn,
    required this.overallTarget,
    required this.primaryActivation,
    required this.secondaryActivation,
    required this.reps,
    required this.sets,
    required this.howTo,
  });
}

class HowTo {
  final String videoLink;
  const HowTo({required this.videoLink});
}

List<ExerciseModel> getAllExercises() {
  final allExercises = [
    const ExerciseModel(
      name: 'Pullups',
      assetLocation: 'https://i.stack.imgur.com/AY9Xl.png',
      benefits: '',
      includedIn: 'Upper',
      overallTarget: 'Upper',
      primaryActivation: 'Lats',
      secondaryActivation: 'Arms',
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
      overallTarget: 'Legs',
      primaryActivation: 'Quads',
      secondaryActivation: 'Glutes',
      reps: 0,
      sets: 0,
      howTo: null,
    ),
    const ExerciseModel(
      name: 'Test',
      assetLocation:
          'https://fitnessprogramer.com/wp-content/uploads/2022/08/how-to-do-pull-up.gif',
      benefits: '',
      includedIn: 'Upper',
      overallTarget: 'Test3',
      primaryActivation: 'Test1',
      secondaryActivation: 'Test2',
      reps: 0,
      sets: 0,
      howTo: null,
    ),
    const ExerciseModel(
      name: 'Climbing',
      assetLocation:
          'https://s3.amazonaws.com/www.explorersweb.com/wp-content/uploads/2022/03/25004754/ondra.jpg',
      benefits: '',
      includedIn: '',
      overallTarget: 'All',
      primaryActivation: 'Skills',
      secondaryActivation: 'Arms',
      reps: 0,
      sets: 0,
      howTo: null,
    ),
  ];
  return allExercises;
}

Future<List> getFilteredExercises() async {
  final val = await getAllExercises();
  for (final filteredExercises
      in val.where((element) => element.includedIn == element.overallTarget)) {
    filteredExercises;
  }

  final filteredExercises = getAllExercises();
  return filteredExercises;
}
