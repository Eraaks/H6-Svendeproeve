class ExerciseModel {
  late String _name;
  late String _description;
  late String _assetLocation;
  late String _howToLocation;
  late String _muscleGroupLocation;
  late String _benefits;
  late List<String> _includedIn;
  late String _overallTarget;
  late List<String> _primaryActivation;
  late List<String> _secondaryActivation;
  late int _reps;
  late int _sets;

  ExerciseModel({
    required String name,
    required String description,
    required String muscleGroupLocation,
    required String assetLocation,
    required String howToLocation,
    required String benefits,
    required List<String> includedIn,
    required String overallTarget,
    required List<String> primaryActivation,
    required List<String> secondaryActivation,
    required int reps,
    required int sets,
  });

  String get name => _name;
  set name(String? name) => _name = name!;

  String get description => _description;
  set description(String? description) => _description = description!;

  String get assetLocation => _assetLocation;
  set assetLocation(String? assetLocation) => _assetLocation = assetLocation!;

  String get howToLocation => _howToLocation;
  set howToLocation(String? howToLocation) => _howToLocation = howToLocation!;

  String get muscleGroupLocation => _muscleGroupLocation;
  set muscleGroupLocation(String? muscleGroupLocation) =>
      _muscleGroupLocation = muscleGroupLocation!;

  String get benefits => _benefits;
  set benefits(String? benefits) => _benefits = benefits!;

  List<String> get includedIn => _includedIn;
  set includedIn(List<String>? includedIn) => _includedIn = includedIn!;

  String get overallTarget => _overallTarget;
  set overallTarget(String? overallTarget) => _overallTarget = overallTarget!;

  List<String> get primaryActivation => _primaryActivation;
  set primaryActivation(List<String>? primaryActivation) =>
      _primaryActivation = primaryActivation!;

  List<String> get secondaryActivation => _secondaryActivation;
  set secondaryActivation(List<String>? secondaryActivation) =>
      _secondaryActivation = secondaryActivation!;

  int get reps => _reps;
  set reps(int? reps) => _reps = reps!;

  int get sets => _sets;
  set sets(int? sets) => _sets = sets!;

  ExerciseModel.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _description = json['description'],
        _assetLocation = json['asset_Location'],
        _benefits = json['benefits'],
        _includedIn = List<String>.from(json['included_In']),
        _overallTarget = json['overall_Target'],
        _primaryActivation = List<String>.from(json['primary_Activation']),
        _secondaryActivation = List<String>.from(json['secondary_Activation']),
        _reps = json['reps'],
        _sets = json['sets'],
        _howToLocation = json['howto_Location'],
        _muscleGroupLocation = json['musclegroup_Location'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': _name,
      'description': _description,
      'asset_location': _assetLocation,
      'benefits': _benefits,
      'included_In': _includedIn,
      'overall_Target': _overallTarget,
      'primary_Activation': _primaryActivation,
      'secondary_Activation': _secondaryActivation,
      'reps': _reps,
      'sets': _sets,
      'howto_Location': _howToLocation,
      'musclegroup_Location': _muscleGroupLocation,
    };
    return data;
  }
}
