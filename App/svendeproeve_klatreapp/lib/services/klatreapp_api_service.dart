import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:svendeproeve_klatreapp/models/climbing_center.dart';

class APIService {
  static const FlutterSecureStorage storage = FlutterSecureStorage();
  static const String _baseUrlLocal = 'https://10.0.2.2:44380/';
  List<ClimbingCenter> climbingCenters = [];
  // getClimbingscore(String requestPath) async {
  //   final headers = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
  //   };
  //   return http.get(Uri.parse(_baseUrlLocal + requestPath), headers: headers);
  // }

  Future<List<ClimbingCenter>> getAllClimbingCenters() async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
    };

    var request = await http.get(Uri.parse('${_baseUrlLocal}GetClimbingCentre'),
        headers: headers);

    if (request.statusCode == 200) {
      var encodedString = json.decode(request.body);
      for (var i = 0; i < encodedString.length; i++) {
        climbingCenters.add(
            ClimbingCenter.fromJson(encodedString[i] as Map<String, dynamic>));
      }
    }

    return climbingCenters;
  }
}
