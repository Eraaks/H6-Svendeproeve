class ClimbingScore {
  String? _userUID;
  int? _rank;
  String? _name;
  String? _centerName;
  int? _score;
  String? _grade;

  ClimbingScore(
      {String? userUID,
      int? rank,
      String? name,
      String? centerName,
      int? score,
      String? grade}) {
    if (userUID != null) {
      this._userUID = userUID;
    }
    if (rank != null) {
      this._rank = rank;
    }
    if (name != null) {
      this._name = name;
    }
    if (centerName != null) {
      this._centerName = centerName;
    }
    if (score != null) {
      this._score = score;
    }
    if (grade != null) {
      this._grade = grade;
    }
  }

  String? get userUID => _userUID;
  set userUID(String? userUID) => _userUID = userUID;
  int? get rank => _rank;
  set rank(int? rank) => _rank = rank;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get centerName => _centerName;
  set centerName(String? centerName) => _centerName = centerName;
  int? get score => _score;
  set score(int? score) => _score = score;
  String? get grade => _grade;
  set grade(String? grade) => _grade = grade;

  ClimbingScore.fromJson(Map<String, dynamic> json) {
    _userUID = json['userUID'];
    _rank = json['rank'];
    _name = json['name'];
    _centerName = json['center_Name'];
    _score = json['score'];
    _grade = json['grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userUID'] = this._userUID;
    data['rank'] = this._rank;
    data['name'] = this._name;
    data['center_Name'] = this._centerName;
    data['score'] = this._score;
    data['grade'] = this._grade;
    return data;
  }
}
