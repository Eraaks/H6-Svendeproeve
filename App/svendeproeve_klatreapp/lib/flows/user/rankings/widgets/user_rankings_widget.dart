import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/flows/user/rankings/person_page.dart';
import 'package:svendeproeve_klatreapp/models/climbing_score.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';
import 'package:svendeproeve_klatreapp/services/database_service.dart';
import 'package:svendeproeve_klatreapp/services/klatreapp_api_service.dart';

class RankingsWidgets extends StatefulWidget {
  final String SelectedGym;
  const RankingsWidgets({Key? key, required this.SelectedGym})
      : super(key: key);

  @override
  State<RankingsWidgets> createState() =>
      _RankingsWidgetsState(SelectedGym: SelectedGym);
}

class _RankingsWidgetsState extends State<RankingsWidgets> {
  final String SelectedGym;

  _RankingsWidgetsState({required this.SelectedGym});

  static final APIService _apiService = APIService();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<List<ClimbingScore>>? climbingScoreList;
  List<String>? followList;
  @override
  void initState() {
    super.initState();
    print('Rankings Page');
    _initClimbingscore();
    _initFollowList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initClimbingscore() async {
    climbingScoreList =
        _apiService.getClimbingScore(SelectedGym.replaceAll(' ', ''));
  }

  Future<void> _initFollowList() async {
    followList = await _apiService.getFollowList(_auth.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: const Topbar(),
      drawer: const Sidebar(),
      body: Column(
        children: [
          Text('Rankings for $SelectedGym',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 500),
            child: FutureBuilder<List<ClimbingScore>>(
              future: climbingScoreList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final climbing = snapshot.data ?? <ClimbingScore>[];
                  return ListView(
                    padding: const EdgeInsets.all(5),
                    children: climbing.map(buildUsers).toList(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildUsers(ClimbingScore snapshotData) => Card(
        elevation: 4,
        child: ExpansionTile(
          trailing: const Icon(
            Icons.arrow_right,
          ),
          title: Text(snapshotData.name!),
          subtitle:
              Text('Rank: ${snapshotData.rank}, Score: ${snapshotData.score}'),
          children: [
            TextButton(
                onPressed: () async {
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonPage(
                                email: snapshotData.name!,
                                userUID: snapshotData.userUID!,
                                following:
                                    followList!.contains(snapshotData.userUID)
                                        ? true
                                        : false,
                                selectedGym: SelectedGym,
                              )));

                  if (result != null) {
                    if (result['following'] == true) {
                      followList!.add(result['userUID']);
                    } else {
                      followList!.remove(result['userUID']);
                    }
                  }
                },
                child: const Text('View User'))
          ],
        ),
      );
}
