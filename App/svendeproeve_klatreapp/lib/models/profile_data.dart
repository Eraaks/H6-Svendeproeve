class ProfileData {
  String? _id;
  List<String>? _followsMe;
  List<String>? _friendIds;
  List<String>? _savedExercises;
  List<String>? _savedWorkouts;
  String? _userEmail;
  String? _selectedGym;
  List<ClimbingHistory>? _climbingHistory;

  ProfileData(
      {String? id,
      List<String>? followsMe,
      List<String>? friendIds,
      List<String>? savedExercises,
      List<String>? savedWorkouts,
      String? userEmail,
      String? selectedGym,
      List<ClimbingHistory>? climbingHistory}) {
    if (id != null) {
      this._id = id;
    }
    if (followsMe != null) {
      this._followsMe = followsMe;
    }
    if (friendIds != null) {
      this._friendIds = friendIds;
    }
    if (savedExercises != null) {
      this._savedExercises = savedExercises;
    }
    if (savedWorkouts != null) {
      this._savedWorkouts = savedWorkouts;
    }
    if (userEmail != null) {
      this._userEmail = userEmail;
    }
    if (selectedGym != null) {
      this._selectedGym = selectedGym;
    }
    if (climbingHistory != null) {
      this._climbingHistory = climbingHistory;
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
  String? get userEmail => _userEmail;
  set userEmail(String? userEmail) => _userEmail = userEmail;
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
    _userEmail = json['user_Email'];
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
    data['id'] = this._id;
    data['follows_Me'] = this._followsMe;
    data['friend_Ids'] = this._friendIds;
    data['saved_Exercises'] = this._savedExercises;
    data['saved_Workouts'] = this._savedWorkouts;
    data['user_Email'] = this._userEmail;
    data['selected_Gym'] = this._selectedGym;
    if (this._climbingHistory != null) {
      data['climbing_History'] =
          this._climbingHistory!.map((v) => v.toJson()).toList();
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
      this._id = id;
    }
    if (estimatedGrade != null) {
      this._estimatedGrade = estimatedGrade;
    }
    if (location != null) {
      this._location = location;
    }
    if (totalPoints != null) {
      this._totalPoints = totalPoints;
    }
    if (sendCollections != null) {
      this._sendCollections = sendCollections;
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
    data['id'] = this._id;
    data['estimated_Grade'] = this._estimatedGrade;
    data['location'] = this._location;
    data['total_Points'] = this._totalPoints;
    if (this._sendCollections != null) {
      data['send_Collections'] =
          this._sendCollections!.map((v) => v.toJson()).toList();
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
      this._id = id;
    }
    if (area != null) {
      this._area = area;
    }
    if (grade != null) {
      this._grade = grade;
    }
    if (points != null) {
      this._points = points;
    }
    if (tries != null) {
      this._tries = tries;
    }
    if (sendDate != null) {
      this._sendDate = sendDate;
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
    data['id'] = this._id;
    data['area'] = this._area;
    data['grade'] = this._grade;
    data['points'] = this._points;
    data['tries'] = this._tries;
    data['sendDate'] = this._sendDate;
    return data;
  }
}
