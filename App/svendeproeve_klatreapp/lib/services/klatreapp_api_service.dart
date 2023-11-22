import 'dart:convert';

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:svendeproeve_klatreapp/models/climbing_center.dart';
import 'package:svendeproeve_klatreapp/models/exercise_model.dart';
import 'package:svendeproeve_klatreapp/models/grips_model.dart';
import 'package:svendeproeve_klatreapp/models/profile_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/climbing_score.dart';

class TokenResult {
  final bool success;
  final String selectedGym;
  final ProfileData profileData;
  final bool isModerator;

  TokenResult(
      {required this.success,
      required this.selectedGym,
      required this.profileData,
      required this.isModerator});
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class APIService {
  static const FlutterSecureStorage storage = FlutterSecureStorage();
  // static const String _baseUrlLocal = 'https://10.0.2.2:44380/';
  static const String _baseUrlLocal = 'https://10.0.2.2:7239/';
  List<GripsModel> grips = [];
  List<ClimbingCenter> climbingCenters = [];
  List<ExerciseModel> exercises = [];

  Future<TokenResult> GetAPIToken(storage, User user) async {
    String secret = await storage.read(key: 'Secret');

    secret = Uri.encodeComponent(secret)
        .replaceAll('*', '%2A')
        .replaceAll('!', '%21')
        .replaceAll('25', '');

    var uri = '${_baseUrlLocal}Login/$secret&${user.uid}';
    var request = await http.get(Uri.parse(uri));

    if (request.statusCode == 200) {
      await storage.write(key: 'Token', value: request.body);
      var moderatorCode = await storage.read(key: 'ModeratorCode');
      var profileExists = await profileDataExists(user.uid);

      if (profileExists == false) {
        await createProfileData(user.uid, user.email!, moderatorCode);
      }
      var profile = await getProfileData(user.uid);
      var isModerator =
          await checkIfUserModerator(user.uid, profile!.selectedGym!);
      return TokenResult(
          success: true,
          selectedGym: profile.selectedGym!
              .split(' ')
              .map((word) => word.capitalize())
              .join(' '),
          profileData: profile,
          isModerator: isModerator!);
    } else {
      return TokenResult(
          success: false,
          selectedGym: '',
          profileData: ProfileData(),
          isModerator: false);
    }
  }

  Future<TokenResult?> getFirebaseSecret() async {
    try {
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
        return GetAPIToken(storage, user!);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<ClimbingCenter>?> getAllClimbingCenters() async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };

      var request = await http.get(
          Uri.parse('${_baseUrlLocal}GetClimbingCentre'),
          headers: headers);

      if (request.statusCode == 200) {
        var encodedString = json.decode(request.body);
        for (var i = 0; i < encodedString.length; i++) {
          climbingCenters.add(ClimbingCenter.fromJson(
              encodedString[i] as Map<String, dynamic>));
        }
      }
      return climbingCenters;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<GripsModel>?> getAllGrips() async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };
      var request = await http.get(Uri.parse('${_baseUrlLocal}Grips/GetGrips'),
          headers: headers);

      if (request.statusCode == 200) {
        var encodedString = json.decode(request.body);
        for (var i = 0; i < encodedString.length; i++) {
          grips.add(
              GripsModel.fromJson(encodedString[i] as Map<String, dynamic>));
        }
      }
      return grips;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<ExerciseModel>?> getAllExercises() async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };
      var request = await http.get(
          Uri.parse('${_baseUrlLocal}ExerciseController/GetExercises'),
          headers: headers);

      if (request.statusCode == 200) {
        var encodedString = json.decode(request.body);
        for (var i = 0; i < encodedString.length; i++) {
          exercises.add(
              ExerciseModel.fromJson(encodedString[i] as Map<String, dynamic>));
        }
      }
      return exercises;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<ExerciseModel>?> getIncludedInExercises(musclegroup) async {
    try {
      exercises = [];
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };
      var request = await http.get(
          Uri.parse(
              '${_baseUrlLocal}ExerciseController/GetExercisesIncludedIn/$musclegroup'),
          headers: headers);

      if (request.statusCode == 200) {
        var encodedString = json.decode(request.body);
        for (var i = 0; i < encodedString.length; i++) {
          exercises.add(
              ExerciseModel.fromJson(encodedString[i] as Map<String, dynamic>));
        }
      }
      return exercises;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<ClimbingScore>?> getClimbingScore(String centerName) async {
    try {
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
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool?> updateFollow(String userUID, String userToFollowUserUID) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };

      var request = await http.patch(
          Uri.parse(
              '${_baseUrlLocal}UpdateFollow/$userUID&$userToFollowUserUID'),
          headers: headers);

      if (request.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool?> removeFollow(String userUID, String userToFollowUserUID) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };

      var request = await http.delete(
          Uri.parse(
              '${_baseUrlLocal}RemoveFollow/$userUID&$userToFollowUserUID'),
          headers: headers);

      if (request.statusCode == 200) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<String>?> getFollowList(String userUID) async {
    try {
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
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool?> profileDataExists(String userUID) async {
    try {
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
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<ProfileData?> getProfileData(String userUID) async {
    try {
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
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> createProfileData(
      String userUID, String email, String moderatorCode) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };

      await http.post(
          Uri.parse(
              '${_baseUrlLocal}NewProfileDataAsync/$userUID&$email?moderatorCode=$moderatorCode'),
          headers: headers);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> createIssue(String title, String description, bool isBug) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };
      await http.post(
          Uri.parse('${_baseUrlLocal}CreateIssue/$title&$description&$isBug'),
          headers: headers);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<Areas>?> getCenterRoutes(String centerName) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };
      var request = await http.get(
          Uri.parse('${_baseUrlLocal}GetCenterRoutes/$centerName'),
          headers: headers);

      if (request.statusCode == 200) {
        var encodedString = json.decode(request.body);
        List<Areas> areas = [];
        for (var i = 0; i < encodedString.length; i++) {
          areas.add(Areas.fromJson(encodedString[i] as Map<String, dynamic>));
        }
        return areas;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> updateRouteCompleters(List<AreaRoutes> routes,
      String climbingCenterName, String userUID) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };

      await http.patch(
          Uri.parse(
              '${_baseUrlLocal}UpdateRouteCompleters/$climbingCenterName&$userUID'),
          headers: headers,
          body: jsonEncode(routes));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> submitUserClimb(List<AreaRoutes> routes, String userUID,
      String climbingCenterName) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };

      await http.post(
          Uri.parse(
              '${_baseUrlLocal}SubmitUserClimb/$userUID&$climbingCenterName'),
          headers: headers,
          body: jsonEncode(routes));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateSelectedGym(String userUID, String newSelectedGym) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };

      await http.patch(
          Uri.parse(
              '${_baseUrlLocal}UpdateSelectedGym/$userUID&$newSelectedGym'),
          headers: headers);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<String>?> getClimbingCentreNames() async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };

      var request = await http.get(
          Uri.parse('${_baseUrlLocal}GetClimbingCentreNames'),
          headers: headers);

      if (request.statusCode == 200) {
        var encodedString = json.decode(request.body);
        List<String> climbingCentreNames = [];
        for (var i = 0; i < encodedString.length; i++) {
          climbingCentreNames.add(encodedString[i]);
        }
        return climbingCentreNames;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> updateClimbingArea(
      String climbingCenterName,
      String climbingArea,
      String userUID,
      String fieldToChange,
      String newValue) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };
      await http.patch(
          Uri.parse(
              '${_baseUrlLocal}UpdateClimbingArea/$climbingCenterName&$climbingArea&$fieldToChange&$newValue&$userUID'),
          headers: headers);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateClimbingRoute(
    String climbingCenterName,
    String climbingArea,
    String userUID,
    String problemID,
  ) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };
      await http.patch(
          Uri.parse(
              '${_baseUrlLocal}UpdateClimbingArea/$climbingCenterName&$climbingArea&$problemID&$userUID'),
          headers: headers);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> createClimbingRoute(
    String climbingCenterName,
    String climbingArea,
    String userUID,
    List<AreaRoutes> routes,
  ) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };
      await http.post(
          Uri.parse(
              '${_baseUrlLocal}AddRoutesToArea/$climbingCenterName&$climbingArea&$userUID'),
          headers: headers,
          body: jsonEncode(routes));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool?> deleteClimbingArea(
      String userUID, String climbingCenterName, String climbingArea) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };

      var request = await http.delete(
          Uri.parse(
              '${_baseUrlLocal}DeleteClimbingArea/$climbingCenterName&$climbingArea&$userUID'),
          headers: headers);

      if (request.statusCode == 200) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool?> deleteClimbingRoute(String userUID, String climbingCenterName,
      String climbingArea, String problemID) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };

      var request = await http.delete(
          Uri.parse(
              '${_baseUrlLocal}DeleteClimbingArea/$climbingCenterName&$climbingArea&$problemID&$userUID'),
          headers: headers);

      if (request.statusCode == 200) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool?> checkIfUserModerator(
      String userUID, String climbingCenterName) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await storage.read(key: 'Token')}'
      };

      var request = await http.get(
          Uri.parse(
              '${_baseUrlLocal}CheckIfUserModerator/$userUID&$climbingCenterName'),
          headers: headers);
      if (request.statusCode == 200 && json.decode(request.body) == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
