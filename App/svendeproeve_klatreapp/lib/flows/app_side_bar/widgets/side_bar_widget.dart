import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/user/overview/user_overview_page.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/models/climbing_center.dart';

class SidebarWidgets extends StatefulWidget {
  const SidebarWidgets({Key? key}) : super(key: key);

  @override
  State<SidebarWidgets> createState() => _SidebarWidgetsState();
}

class _SidebarWidgetsState extends State<SidebarWidgets> {
  final controller = TextEditingController();
  final clearController = TextEditingController();
  List<ClimbingCenter> centers = _getAllClimbingCenters();

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
              onChanged: searchCenter,
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: centers.length,
              itemBuilder: (context, index) {
                final center = centers[index];
                return ListTile(
                    title: Text(center.country),
                    subtitle: Text(center.place),
                    onTap: () {
                      Navigator.of(context).pop(center.place);
                    });
              },
            ),
          ],
        ),
      );

  void searchCenter(String query) {
    final suggestions = _getAllClimbingCenters().where((center) {
      final centerPlace = center.place.toLowerCase();
      final input = query.toLowerCase();

      return centerPlace.contains(input);
    }).toList();

    setState(() => centers = suggestions);
  }
}

List<ClimbingCenter> _getAllClimbingCenters() {
  final allClimbingCenters = [
    const ClimbingCenter(country: 'Denmark', place: 'Beta Boulders'),
    const ClimbingCenter(country: 'Denmark', place: 'Boulders Syd')
  ];
  return allClimbingCenters;
}
