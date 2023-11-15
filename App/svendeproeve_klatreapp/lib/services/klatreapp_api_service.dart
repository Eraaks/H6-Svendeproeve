import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:svendeproeve_klatreapp/models/climbing_center.dart';
import 'package:svendeproeve_klatreapp/models/profile_data.dart';

import '../models/climbing_score.dart';

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

  Future<bool> GetAPIToken(storage, User user) async {
    String secret = await storage.read(key: 'Secret');
    secret = Uri.encodeComponent(secret)
        .replaceAll('*', '%2A')
        .replaceAll('!', '%21')
        .replaceAll('25', '');

    var uri = 'https://10.0.2.2:44380/Login/$secret&${user.uid}';
    var request = await http.get(Uri.parse(uri));

    if (request.statusCode == 200) {
      await storage.write(key: 'Token', value: request.body);

      var profile = await profileDataExists(user.uid);
      if (profile == false) {
        await createProfileData(user.uid, user.email!);
      }
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getFirebaseSecret() async {
    const storage = FlutterSecureStorage();
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    String? value = await storage.read(key: 'Secret');
    if (value == null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _db
          .collection('Login Verification')
          .doc('PBTElOYPubm6W28jj5jT')
          .get();

      await storage.write(key: 'Secret', value: snapshot.data()?['Secret']);
    }

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (await storage.read(key: 'Secret') != null) {
      return GetAPIToken(storage, user!);
    } else {
      return false;
    }
  }

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

  Future<List<ClimbingScore>> getClimbingScore(String centerName) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
    };

    List<ClimbingScore> climbingScores = [];

    var request = await http.get(
        Uri.parse('${_baseUrlLocal}GetClimbingScore/$centerName'),
        headers: headers);

    if (request.statusCode == 200) {
      var encodedString = json.decode(request.body);
      for (var i = 0; i < encodedString.length; i++) {
        climbingScores.add(
            ClimbingScore.fromJson(encodedString[i] as Map<String, dynamic>));
      }
    }

    return climbingScores;
  }

  Future<bool> updateFollow(String userUID, String userToFollowUserUID) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
    };

    var request = await http.patch(
        Uri.parse('${_baseUrlLocal}UpdateFollow/$userUID&$userToFollowUserUID'),
        headers: headers);

    if (request.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> removeFollow(String userUID, String userToFollowUserUID) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
    };

    var request = await http.delete(
        Uri.parse('${_baseUrlLocal}RemoveFollow/$userUID&$userToFollowUserUID'),
        headers: headers);

    if (request.statusCode == 200) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<String>> getFollowList(String userUID) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
    };

    List<String> followList = [];
    var request = await http.get(
        Uri.parse('${_baseUrlLocal}GetFollowList/$userUID'),
        headers: headers);

    if (request.statusCode == 200) {
      var encodedString = json.decode(request.body);
      for (var i = 0; i < encodedString.length; i++) {
        followList.add(encodedString[i]);
      }
    }

    return followList;
  }

  Future<bool> profileDataExists(String userUID) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
    };

    var request = await http.get(
        Uri.parse('${_baseUrlLocal}GetProfileData/$userUID'),
        headers: headers);

    if (request.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<ProfileData> getProfileData(String userUID) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
    };

    var request = await http.get(
        Uri.parse('${_baseUrlLocal}GetProfileData/$userUID'),
        headers: headers);

    if (request.statusCode == 200) {
      var encodedString = json.decode(request.body);
      return ProfileData.fromJson(encodedString as Map<String, dynamic>);
    } else {
      return ProfileData();
    }
  }

  Future<void> createProfileData(String userUID, String email) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
    };

    await http.post(
        Uri.parse('${_baseUrlLocal}NewProfileDataAsync/$userUID&$email'),
        headers: headers);
  }

  Future<void> createIssue(String title, String description, bool isBug) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
    };
    await http.post(
        Uri.parse('${_baseUrlLocal}CreateIssue/$title&$description&$isBug'),
        headers: headers);
  }
}
