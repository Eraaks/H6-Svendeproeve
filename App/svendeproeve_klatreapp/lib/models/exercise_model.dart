class ExerciseModel {
  late String _name;
  late String _assetLocation;
  late String _benefits;
  late List<String> _includedIn; // Change the type to List<String>
  late String _overallTarget;
  late List<String> _primaryActivation; // Change the type to List<String>
  late List<String> _secondaryActivation; // Change the type to List<String>
  late int _reps;
  late int _sets;
  late HowTo? _howTo;

  ExerciseModel({
    required String name,
    required String assetLocation,
    required String benefits,
    required List<String> includedIn, // Change the type to List<String>
    required String overallTarget,
    required List<String> primaryActivation, // Change the type to List<String>
    required List<String>
        secondaryActivation, // Change the type to List<String>
    required int reps,
    required int sets,
    required HowTo howTo,
  });

  String get name => _name;

  set name(String? name) => _name = name!;

  String get assetLocation => _assetLocation;
  set assetLocation(String? assetLocation) => _assetLocation = assetLocation!;

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
        _assetLocation = json['asset_location'],
        _benefits = json['benefits'],
        _includedIn = List<String>.from(json['included_In']),
        _overallTarget = json['overall_Target'],
        _primaryActivation = List<String>.from(json['primary_Activation']),
        _secondaryActivation = List<String>.from(json['secondary_Activation']),
        _reps = json['reps'],
        _sets = json['sets'],
        _howTo = HowTo.fromJson(json['how_To'] ?? {});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': _name,
      'asset_location': _assetLocation,
      'benefits': _benefits,
      'included_In': _includedIn, // Serialize the List
      'overall_Target': _overallTarget,
      'primary_Activation': _primaryActivation, // Serialize the List
      'secondary_Activation': _secondaryActivation, // Serialize the List
      'reps': _reps,
      'sets': _sets,
      'how_To': _howTo?.toJson() ?? {},
    };
    return data;
  }
}

class HowTo {
  late String _videoLink;

  HowTo({
    required String videoLink,
  });

  factory HowTo.fromJson(Map<String, dynamic> json) {
    return HowTo(
      videoLink: json['video_Link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'video_Link': _videoLink,
    };
  }
}
