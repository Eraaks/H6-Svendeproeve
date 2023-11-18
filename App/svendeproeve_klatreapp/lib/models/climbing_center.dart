class ClimbingCenter {
  String? _centerName;
  String? _description;
  String? _location;
  String? _moderatorCode;
  List<String>? _moderators;
  List<String>? _areaNames;
  List<Areas>? _areas;

  ClimbingCenter(
      {String? centerName,
      String? description,
      String? location,
      String? moderatorCode,
      List<String>? moderators,
      List<String>? areaNames,
      List<Areas>? areas}) {
    if (centerName != null) {
      this._centerName = centerName;
    }
    if (description != null) {
      this._description = description;
    }
    if (location != null) {
      this._location = location;
    }
    if (moderatorCode != null) {
      this._moderatorCode = moderatorCode;
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

  String? get centerName => _centerName;
  set centerName(String? centerName) => _centerName = centerName;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get location => _location;
  set location(String? location) => _location = location;
  String? get moderatorCode => _moderatorCode;
  set moderatorCode(String? moderatorCode) => _moderatorCode = moderatorCode;
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
  String? _id;
  String? _color;
  String? _grade;
  List<String>? _usersWhoCompleted;
  List<String>? _usersWhoFlashed;
  int? _number;

  AreaRoutes(
      {String? id,
      String? color,
      String? grade,
      List<String>? usersWhoCompleted,
      List<String>? usersWhoFlashed,
      int? number}) {
    if (id != null) {
      this._id = id;
    }
    if (color != null) {
      this._color = color;
    }
    if (grade != null) {
      this._grade = grade;
    }
    if (usersWhoCompleted != null) {
      this._usersWhoCompleted = usersWhoCompleted;
    }
    if (usersWhoFlashed != null) {
      this._usersWhoFlashed = usersWhoFlashed;
    }
    if (number != null) {
      this._number = number;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get color => _color;
  set color(String? color) => _color = color;
  String? get grade => _grade;
  set grade(String? grade) => _grade = grade;
  List<String>? get usersWhoCompleted => _usersWhoCompleted;
  set usersWhoCompleted(List<String>? usersWhoCompleted) =>
      _usersWhoCompleted = usersWhoCompleted;
  List<String>? get usersWhoFlashed => _usersWhoFlashed;
  set usersWhoFlashed(List<String>? usersWhoFlashed) =>
      _usersWhoFlashed = usersWhoFlashed;
  int? get number => _number;
  set number(int? number) => _number = number;

  AreaRoutes.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _color = json['color'];
    _grade = json['grade'];
    _usersWhoCompleted = json['usersWhoCompleted'].cast<String>();
    _usersWhoFlashed = json['usersWhoFlashed'].cast<String>();
    _number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['color'] = this._color;
    data['grade'] = this._grade;
    data['usersWhoCompleted'] = this._usersWhoCompleted;
    data['usersWhoFlashed'] = this._usersWhoFlashed;
    data['number'] = this._number;
    return data;
  }
}
