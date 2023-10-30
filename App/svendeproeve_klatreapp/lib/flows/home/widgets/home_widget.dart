import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/widgets/side_bar_widget.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';

final AuthService _auth = AuthService();
final Sidebar _Sidebar = Sidebar();

class HomeWidgets extends StatefulWidget {
  const HomeWidgets({Key? key}) : super(key: key);

  @override
  State<HomeWidgets> createState() => _HomeWidgetsState();
}

class _HomeWidgetsState extends State<HomeWidgets> {
  var selectedClimbingPlace = 'Please Select Climbing Place';
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackgroundColor,
      appBar: reusableAppBar(),
      drawer: Sidebar(),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              selectedClimbingPlace,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              child: const Text(
                'Select',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Denmark'),
                        content: setupAlertDialoadContainer(),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget setupAlertDialoadContainer() {
  return SizedBox(
      height: 400.0,
      width: 400.0,
      child: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text('Boulders'),
              onTap: () {},
            );
          },
        ),
      ));
}
