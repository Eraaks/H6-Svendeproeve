import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:svendeproeve_klatreapp/models/climbing_score.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Future<List<ClimbingScore>> getClimbingscore() async {
  //   QuerySnapshot<Map<String, dynamic>> snapshot = await _db
  //       .collection('Climbing_Score')
  //       .orderBy('score', descending: false)
  //       .get();
  //   return snapshot.docs
  //       .map((docSnapshot) => ClimbingScore.fromDocumentSnapshot(docSnapshot))
  //       .toList();
  // }

// Future<List<SavedWorkout>> getSavedWorkouts(String userEmail) async {
//     late List<dynamic> workoutIds;

//     //get workout ids
//     await _db
//       .collection('profile_data')
//       .where('user_email', isEqualTo: userEmail)
//       .get()
//       .then((value) {
//         workoutIds = value.docs.first.data()['saved_workouts'];
//         debugPrint('workoutids: $workoutIds');
//     });

//     //get workouts based on workout ids
//     QuerySnapshot<Map<String, dynamic>> snapshot = await _db
//         .collection('saved_workouts')
//         .where(FieldPath.documentId, whereIn: workoutIds)
//         .get();

//     //return document snapshot of found workouts.
//     return snapshot.docs
//         .map((docSnapshot) => SavedWorkout.fromDocumentSnapshot(docSnapshot))
//         .toList();
//   }
}
