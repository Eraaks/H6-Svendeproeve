import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/flows/reusable/restart_app.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/services/klatreapp_api_service.dart';

class HomeWidgets extends StatefulWidget {
  final String selectedGym;
  const HomeWidgets({Key? key, required this.selectedGym}) : super(key: key);

  @override
  State<HomeWidgets> createState() =>
      _HomeWidgetsState(selectedGym: selectedGym);
}

class _HomeWidgetsState extends State<HomeWidgets> {
  final String selectedGym;
  _HomeWidgetsState({required this.selectedGym});

  static final APIService _apiService = APIService();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final _controller = TextEditingController();
  Future<List<String>?>? centerNames;

  @override
  void initState() {
    super.initState();
    getClimbingCentreNames();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> getClimbingCentreNames() async {
    centerNames = _apiService.getClimbingCentreNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: const Topbar(),
      drawer: const Sidebar(),
      body: Column(
        children: <Widget>[
          Text(
            'Current gym:\n $selectedGym\n\n You can switch to a different gym here:',
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 500),
            child: FutureBuilder<List<String>?>(
              future: centerNames,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final data = snapshot.data ?? <String>[];
                  return ListView(
                    padding: const EdgeInsets.all(5),
                    children: data.map(builderCenterName).toList(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget builderCenterName(String data) {
    return selectedGym != data
        ? Card(
            elevation: 4,
            child: ExpansionTile(
              trailing: const Icon(
                Icons.arrow_right,
              ),
              title: Text(data),
              children: [
                TextButton(
                    onPressed: () async {
                      _apiService.updateSelectedGym(
                          _auth.currentUser!.uid, data);

                      RestartWidget.restartApp(context);
                    },
                    child: const Text('Switch to this climbing gym'))
              ],
            ),
          )
        : const Card();
  }
}
