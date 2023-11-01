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
