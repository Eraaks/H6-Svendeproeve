import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/flows/moderator/overview/moderator_overview_helper.dart';
import 'package:svendeproeve_klatreapp/flows/moderator/overview/widgets/moderator_datatable_widget.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/models/problems_model.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';
import 'package:svendeproeve_klatreapp/services/klatreapp_api_service.dart';

class ModOverviewWidgets extends StatefulWidget {
  const ModOverviewWidgets({Key? key}) : super(key: key);

  @override
  State<ModOverviewWidgets> createState() => _ModOverviewWidgetsState();
}

class _ModOverviewWidgetsState extends State<ModOverviewWidgets> {
  List<ProblemsModel> problemsList = getAllProblems();
  List<ClimbingAreaModel> climbingAreas = getAllClimbingAreas();
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = 'Color red'; // Set an initial value for the dropdown
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: const Topbar(),
      drawer: const Sidebar(),
      body: Center(
        child: Column(
          children: [
            const Text(
              'Beta Boulders South',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: climbingAreas.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const Divider(height: 20, color: Colors.black),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            climbingAreas[index].name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => areaDialog());
                              print('edit area');
                            },
                          ),
                        ],
                      ),
                      DataTableBuilder(
                        problems: climbingAreas[index].problems,
                        updateState: () {
                          setState(() {});
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Add Route:'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => routeDialog(selectedValue));
                              print('add problem');
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            const Divider(height: 20, color: Colors.black),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Add Area:'),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    showDialog(context: context, builder: (_) => areaDialog());
                    print('add area');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
