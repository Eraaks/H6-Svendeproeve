class ProfileData {
  String? _id;
  List<String>? _followsMe;
  List<String>? _friendIds;
  List<String>? _savedExercises;
  List<String>? _savedWorkouts;
  String? _userEmail;
  Null? _climbingHistory;

  ProfileData(
      {String? id,
      List<String>? followsMe,
      List<String>? friendIds,
      List<String>? savedExercises,
      List<String>? savedWorkouts,
      String? userEmail,
      Null? climbingHistory}) {
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
  Null? get climbingHistory => _climbingHistory;
  set climbingHistory(Null? climbingHistory) =>
      _climbingHistory = climbingHistory;

  ProfileData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _followsMe = json['follows_Me'].cast<String>();
    _friendIds = json['friend_Ids'].cast<String>();
    _savedExercises = json['saved_Exercises'].cast<String>();
    _savedWorkouts = json['saved_Workouts'].cast<String>();
    _userEmail = json['user_Email'];
    _climbingHistory = json['climbing_History'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['follows_Me'] = this._followsMe;
    data['friend_Ids'] = this._friendIds;
    data['saved_Exercises'] = this._savedExercises;
    data['saved_Workouts'] = this._savedWorkouts;
    data['user_Email'] = this._userEmail;
    data['climbing_History'] = this._climbingHistory;
    return data;
  }
}
