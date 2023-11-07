class GripsModel {
  late String _gripName;
  late String _gripImg;
  late String _gripDescription;

  GripsModel({
    required String gripName,
    required String gripImg,
    required String gripDescription,
  });

  String get gripName => _gripName;
  set gripName(String? gripName) => _gripName = gripName!;
  String get gripImg => _gripImg;
  set gripImg(String? gripImg) => _gripImg = gripImg!;
  String get gripDescription => _gripDescription;
  set gripDescription(String? gripDescription) =>
      _gripDescription = gripDescription!;

  GripsModel.fromJson(Map<String, dynamic> json) {
    _gripName = json['name'];
    _gripImg = json['image_Location'];
    _gripDescription = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = _gripName;
    data['image_Location'] = _gripImg;
    data['description'] = _gripDescription;
    return data;
  }
}
