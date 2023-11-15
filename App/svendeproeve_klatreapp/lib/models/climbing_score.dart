import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

ClimbingScore? limbingscoreFromMap(String str) =>
    ClimbingScore.fromMap(json.decode(str));
String climbingScoreToMap(ClimbingScore? data) => json.encode(data!.toMap());

class ClimbingScore {
  ClimbingScore({
    required this.useremail,
    required this.username,
    required this.score,
  });

  String useremail;
  String username;
  String? score;

  factory ClimbingScore.fromMap(Map<String, dynamic> json) => ClimbingScore(
        username: json["username"],
        useremail: json["useremail"],
        score: json["score"],
      );

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'useremail': useremail,
      'score': score,
    };
  }

  // named constructor
  ClimbingScore.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : useremail = doc.data()!['useremail'],
        username = doc.data()!['username'],
        score = doc.data()!['score'];
}
