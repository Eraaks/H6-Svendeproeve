import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/flows/moderator/overview/moderator_overview_helper.dart';
import 'package:svendeproeve_klatreapp/flows/moderator/overview/widgets/moderator_datatable_widget.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/models/climbing_center.dart';
import 'package:svendeproeve_klatreapp/models/profile_data.dart';
import 'package:svendeproeve_klatreapp/services/klatreapp_api_service.dart';

class ModOverviewWidgets extends StatefulWidget {
  final String selectedGym;
  final ProfileData profileData;
  const ModOverviewWidgets(
      {Key? key, required this.selectedGym, required this.profileData})
      : super(key: key);

  @override
  State<ModOverviewWidgets> createState() => _ModOverviewWidgetsState(
      selectedGym: selectedGym, profileData: profileData);
}

class _ModOverviewWidgetsState extends State<ModOverviewWidgets> {
  final String selectedGym;
  late String selectedValue;
  final ProfileData profileData;
  _ModOverviewWidgetsState(
      {required this.selectedGym, required this.profileData});
  static final APIService _apiService = APIService();
  Future<List<Areas>?>? areas;
  var editArea = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCenterRoutes(selectedGym);
    selectedValue = 'Red'; // Sets an initial value for the dropdown
  }

  Future<void> getCenterRoutes(String centerName) async {
    areas = _apiService.getCenterRoutes(centerName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: const Topbar(),
      drawer: const Sidebar(),
      body: Center(
        child: FutureBuilder<List<Areas>?>(
          future: areas,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final data = snapshot.data ?? <Areas>[];

              return Column(
                children: [
                  Text(
                    selectedGym,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const Divider(height: 20, color: Colors.black),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data[index].name!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                //Edit Area
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => areaDialog(
                                        true,
                                        context,
                                        selectedGym,
                                        data[index].name,
                                        profileData.id,
                                      ),
                                    );
                                    setState(() {});
                                  },
                                )
                              ],
                            ),
                            DataTableBuilder(
                              area: data[index].name,
                              profileData: widget.profileData,
                              selectedGym: selectedGym,
                              problems: data[index].areaRoutes!,
                              updateState: () {
                                setState(() {});
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Add Problem
                                const Text('Add Route:'),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => problemDialog(
                                          data[index].name,
                                          selectedGym,
                                          false,
                                          data[index].areaRoutes!,
                                          selectedValue,
                                          profileData.id),
                                    );
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
                      //Add Area
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          var edit = false;
                          showDialog(
                            context: context,
                            builder: (_) => areaDialog(edit, context,
                                selectedGym, selectedValue, profileData),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
