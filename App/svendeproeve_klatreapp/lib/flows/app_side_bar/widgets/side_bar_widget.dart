import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/user/overview/user_overview_page.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/models/climbing_center.dart';
import 'package:svendeproeve_klatreapp/services/klatreapp_api_service.dart';

class SidebarWidgets extends StatefulWidget {
  const SidebarWidgets({Key? key}) : super(key: key);

  @override
  State<SidebarWidgets> createState() => _SidebarWidgetsState();
}

class _SidebarWidgetsState extends State<SidebarWidgets> {
  final controller = TextEditingController();
  final clearController = TextEditingController();
  static final APIService _apiService = APIService();
  late Future<List<ClimbingCenter>?> centers;
  // int centersLength = centers.length;

  @override
  void initState() {
    super.initState();

    // initial load
    centers = _apiService.getAllClimbingCenters();
  }

  Future<void> refreshList() async {
    // reload
    setState(() {
      centers = updateAndGetList();
    });
  }

  Future<List<ClimbingCenter>?> updateAndGetList() async {
    // return the list here
    return _apiService.getAllClimbingCenters();
  }

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
      color: topBackgroundColor,
      padding: EdgeInsets.only(
        top: 15 + MediaQuery.of(context).padding.top,
        bottom: 15,
      ),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(
          Icons.arrow_back,
          size: 26,
          color: Colors.white,
        ),
      ));
  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(15),
        child: Wrap(
          runSpacing: 8,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: topBackgroundColor,
                ),
                //TODO: Needed for clearing SearchBar.
                // suffixIcon: IconButton(
                //   onPressed: () {
                //     controller.clear();
                //     _getAllClimbingCenters();
                //   },
                //   icon: Icon(Icons.clear),
                //   color: topBackgroundColor,
                // ),
                hintText: 'Search for place',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: topBackgroundColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: topBackgroundColor),
                ),
              ),
              // onChanged: searchCenter,
            ),
            // const Center(child: CircularProgressIndicator()),
            FutureBuilder(
                future: centers,
                builder: (BuildContext context,
                    AsyncSnapshot<List<ClimbingCenter>?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    var items = snapshot.data ??
                        <ClimbingCenter>[]; // handle the case that data is null
                    return RefreshIndicator(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final center = items[index];
                            return ListTile(
                                title: Text(center.centerName!),
                                subtitle: Text(center.location!),
                                onTap: () {
                                  Navigator.of(context).pop(center.location);
                                });
                          }),
                      onRefresh: refreshList,
                    );
                  }
                }),
          ],
        ),
      );

  // void searchCenter(String query) {
  //   final suggestions = _getAllClimbingCenters(_apiService).where((center) {
  //     final centerPlace = center.place.toLowerCase();
  //     final input = query.toLowerCase();

  //     return centerPlace.contains(input);
  //   }).toList();

  //   setState(() => centers = suggestions);
  // }
}
