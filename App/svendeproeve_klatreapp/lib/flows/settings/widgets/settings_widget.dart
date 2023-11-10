import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/flows/settings/widgets/feedback_widget.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';

class SettingsWidgets extends StatefulWidget {
  const SettingsWidgets({Key? key}) : super(key: key);

  @override
  State<SettingsWidgets> createState() => _SettingsWidgetsState();
}

class _SettingsWidgetsState extends State<SettingsWidgets> {
  final controller = TextEditingController();
  final AuthService _auth = AuthService();
  List<String> items = ['Select Report Type', 'Feedback', 'Bug Report'];
  String? selectedValue = 'Select Report Type';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: reusableAppBar(),
      drawer: const Sidebar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Settings:',
              style: TextStyle(
                fontSize: 18, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Adjust the font weight as needed
              ),
            ),
            const SizedBox(
                height:
                    20), // Add some spacing between the title and the button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200, // Set the desired width
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: topBackgroundColor,
                    ),
                    child: const Text('Logout'),
                    onPressed: () async {
                      await _auth.signOut();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 200, // Set the desired width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: topBackgroundColor,
                ),
                child: const Text('Contact Devs'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FeedbackWidget(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
