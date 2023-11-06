class ClimbingCenter {
  late String _centerName;
  late String _description;
  late String _location;
  late String _moderatorCode;
  List<String>? _moderators;
  List<String>? _areaNames;
  List<Areas>? _areas;

  ClimbingCenter(
      {required String centerName,
      required String description,
      required String location,
      required String moderatorCode,
      List<String>? moderators,
      List<String>? areaNames,
      List<Areas>? areas,
      required String country,
      required String place}) {
    if (centerName != null) {
      _centerName = centerName;
    }
    if (description != null) {
      _description = description;
    }
    if (location != null) {
      _location = location;
    }
    if (moderatorCode != null) {
      _moderatorCode = moderatorCode;
    }
    if (moderators != null) {
      this._moderators = moderators;
    }
    if (areaNames != null) {
      this._areaNames = areaNames;
    }
    if (areas != null) {
      this._areas = areas;
    }
  }

  String get centerName => _centerName;
  set centerName(String? centerName) => _centerName = centerName!;
  String get description => _description;
  set description(String? description) => _description = description!;
  String get location => _location;
  set location(String? location) => _location = location!;
  String get moderatorCode => _moderatorCode;
  set moderatorCode(String? moderatorCode) => _moderatorCode = moderatorCode!;
  List<String>? get moderators => _moderators;
  set moderators(List<String>? moderators) => _moderators = moderators;
  List<String>? get areaNames => _areaNames;
  set areaNames(List<String>? areaNames) => _areaNames = areaNames;
  List<Areas>? get areas => _areas;
  set areas(List<Areas>? areas) => _areas = areas;

  ClimbingCenter.fromJson(Map<String, dynamic> json) {
    _centerName = json['centerName'];
    _description = json['description'];
    _location = json['location'];
    _moderatorCode = json['moderator_Code'];
    _moderators = json['moderators'].cast<String>();
    _areaNames = json['areaNames'].cast<String>();
    if (json['areas'] != null) {
      _areas = <Areas>[];
      json['areas'].forEach((v) {
        _areas!.add(new Areas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['centerName'] = this._centerName;
    data['description'] = this._description;
    data['location'] = this._location;
    data['moderator_Code'] = this._moderatorCode;
    data['moderators'] = this._moderators;
    data['areaNames'] = this._areaNames;
    if (this._areas != null) {
      data['areas'] = this._areas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Areas {
  String? _name;
  String? _description;
  List<AreaRoutes>? _areaRoutes;

  Areas({String? name, String? description, List<AreaRoutes>? areaRoutes}) {
    if (name != null) {
      this._name = name;
    }
    if (description != null) {
      this._description = description;
    }
    if (areaRoutes != null) {
      this._areaRoutes = areaRoutes;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  String? get description => _description;
  set description(String? description) => _description = description;
  List<AreaRoutes>? get areaRoutes => _areaRoutes;
  set areaRoutes(List<AreaRoutes>? areaRoutes) => _areaRoutes = areaRoutes;

  Areas.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _description = json['description'];
    if (json['areaRoutes'] != null) {
      _areaRoutes = <AreaRoutes>[];
      json['areaRoutes'].forEach((v) {
        _areaRoutes!.add(new AreaRoutes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['description'] = this._description;
    if (this._areaRoutes != null) {
      data['areaRoutes'] = this._areaRoutes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AreaRoutes {
  String? _color;
  String? _grade;

  AreaRoutes({String? color, String? grade}) {
    if (color != null) {
      this._color = color;
    }
    if (grade != null) {
      this._grade = grade;
    }
  }

  String? get color => _color;
  set color(String? color) => _color = color;
  String? get grade => _grade;
  set grade(String? grade) => _grade = grade;

  AreaRoutes.fromJson(Map<String, dynamic> json) {
    _color = json['color'];
    _grade = json['grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this._color;
    data['grade'] = this._grade;
    return data;
  }
}
