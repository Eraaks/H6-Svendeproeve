import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/models/climbing_score.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';
import 'package:svendeproeve_klatreapp/services/database_service.dart';

final AuthService _auth = AuthService();
final Sidebar _Sidebar = Sidebar();

class RankingsWidgets extends StatefulWidget {
  const RankingsWidgets({Key? key}) : super(key: key);

  @override
  State<RankingsWidgets> createState() => _RankingsWidgetsState();
}

class _RankingsWidgetsState extends State<RankingsWidgets> {
  final DatabaseService _db = DatabaseService();
  Future<List<ClimbingScore>>? climbingScoreList;

  @override
  void initState() {
    super.initState();
    _initClimbingscore();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initClimbingscore() async {
    climbingScoreList = _db.getClimbingscore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: reusableAppBar(),
      drawer: Sidebar(),
      body: FutureBuilder(
        future: climbingScoreList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final climbing = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(5),
              children: climbing.map(buildUsers).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildUsers(ClimbingScore snapshotData) => Card(
        elevation: 4,
        child: ListTile(
          // onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => PersonProfile(personProfile: snapshotData.useremail)))},
          trailing: const Icon(
            Icons.arrow_right,
          ),
          title: Text(snapshotData.username),
          subtitle: Text('Score: ${snapshotData.score}'),
        ),
      );
}
