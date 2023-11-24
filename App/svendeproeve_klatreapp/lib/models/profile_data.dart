class ProfileData {
  String? _id;
  List<String>? _followsMe;
  List<String>? _friendIds;
  List<String>? _savedExercises;
  List<String>? _savedWorkouts;
  String? _userName;
  String? _selectedGym;
  List<ClimbingHistory>? _climbingHistory;

  ProfileData(
      {String? id,
      List<String>? followsMe,
      List<String>? friendIds,
      List<String>? savedExercises,
      List<String>? savedWorkouts,
      String? userName,
      String? selectedGym,
      List<ClimbingHistory>? climbingHistory}) {
    if (id != null) {
      _id = id;
    }
    if (followsMe != null) {
      _followsMe = followsMe;
    }
    if (friendIds != null) {
      _friendIds = friendIds;
    }
    if (savedExercises != null) {
      _savedExercises = savedExercises;
    }
    if (savedWorkouts != null) {
      _savedWorkouts = savedWorkouts;
    }
    if (userName != null) {
      _userName = userName;
    }
    if (selectedGym != null) {
      _selectedGym = selectedGym;
    }
    if (climbingHistory != null) {
      _climbingHistory = climbingHistory;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  List<String>? get followsMe => _followsMe;
  set followsMe(List<String>? followsMe) => _followsMe = followsMe;
  List<String>? get friendIds => _friendIds;
  set friendIds(List<String>? friendIds) => _friendIds = friendIds;
  List<String>? get savedExercises => _savedExercises;
  set savedExercises(List<String>? savedExercises) =>
      _savedExercises = savedExercises;
  List<String>? get savedWorkouts => _savedWorkouts;
  set savedWorkouts(List<String>? savedWorkouts) =>
      _savedWorkouts = savedWorkouts;
  String? get userName => _userName;
  set userName(String? userName) => _userName = userName;
  String? get selectedGym => _selectedGym;
  set selectedGym(String? selectedGym) => _selectedGym = selectedGym;
  List<ClimbingHistory>? get climbingHistory => _climbingHistory;
  set climbingHistory(List<ClimbingHistory>? climbingHistory) =>
      _climbingHistory = climbingHistory;

  ProfileData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _followsMe = json['follows_Me'].cast<String>();
    _friendIds = json['friend_Ids'].cast<String>();
    _savedExercises = json['saved_Exercises'].cast<String>();
    _savedWorkouts = json['saved_Workouts'].cast<String>();
    _userName = json['username'];
    _selectedGym = json['selected_Gym'];
    if (json['climbing_History'] != null) {
      _climbingHistory = <ClimbingHistory>[];
      json['climbing_History'].forEach((v) {
        _climbingHistory!.add(new ClimbingHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = _id;
    data['follows_Me'] = _followsMe;
    data['friend_Ids'] = _friendIds;
    data['saved_Exercises'] = _savedExercises;
    data['saved_Workouts'] = _savedWorkouts;
    data['username'] = _userName;
    data['selected_Gym'] = _selectedGym;
    if (_climbingHistory != null) {
      data['climbing_History'] =
          _climbingHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClimbingHistory {
  String? _id;
  String? _estimatedGrade;
  String? _location;
  int? _totalPoints;
  List<SendCollections>? _sendCollections;

  ClimbingHistory(
      {String? id,
      String? estimatedGrade,
      String? location,
      int? totalPoints,
      List<SendCollections>? sendCollections}) {
    if (id != null) {
      _id = id;
    }
    if (estimatedGrade != null) {
      _estimatedGrade = estimatedGrade;
    }
    if (location != null) {
      _location = location;
    }
    if (totalPoints != null) {
      _totalPoints = totalPoints;
    }
    if (sendCollections != null) {
      _sendCollections = sendCollections;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get estimatedGrade => _estimatedGrade;
  set estimatedGrade(String? estimatedGrade) =>
      _estimatedGrade = estimatedGrade;
  String? get location => _location;
  set location(String? location) => _location = location;
  int? get totalPoints => _totalPoints;
  set totalPoints(int? totalPoints) => _totalPoints = totalPoints;
  List<SendCollections>? get sendCollections => _sendCollections;
  set sendCollections(List<SendCollections>? sendCollections) =>
      _sendCollections = sendCollections;

  ClimbingHistory.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _estimatedGrade = json['estimated_Grade'];
    _location = json['location'];
    _totalPoints = json['total_Points'];
    if (json['send_Collections'] != null) {
      _sendCollections = <SendCollections>[];
      json['send_Collections'].forEach((v) {
        _sendCollections!.add(new SendCollections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = _id;
    data['estimated_Grade'] = _estimatedGrade;
    data['location'] = _location;
    data['total_Points'] = _totalPoints;
    if (_sendCollections != null) {
      data['send_Collections'] =
          _sendCollections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SendCollections {
  String? _id;
  String? _area;
  String? _grade;
  int? _points;
  int? _tries;
  int? _sendDate;

  SendCollections(
      {String? id,
      String? area,
      String? grade,
      int? points,
      int? tries,
      int? sendDate}) {
    if (id != null) {
      _id = id;
    }
    if (area != null) {
      _area = area;
    }
    if (grade != null) {
      _grade = grade;
    }
    if (points != null) {
      _points = points;
    }
    if (tries != null) {
      _tries = tries;
    }
    if (sendDate != null) {
      _sendDate = sendDate;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get area => _area;
  set area(String? area) => _area = area;
  String? get grade => _grade;
  set grade(String? grade) => _grade = grade;
  int? get points => _points;
  set points(int? points) => _points = points;
  int? get tries => _tries;
  set tries(int? tries) => _tries = tries;
  int? get sendDate => _sendDate;
  set sendDate(int? sendDate) => _sendDate = sendDate;

  SendCollections.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _area = json['area'];
    _grade = json['grade'];
    _points = json['points'];
    _tries = json['tries'];
    _sendDate = json['sendDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = _id;
    data['area'] = _area;
    data['grade'] = _grade;
    data['points'] = _points;
    data['tries'] = _tries;
    data['sendDate'] = _sendDate;
    return data;
  }
}
