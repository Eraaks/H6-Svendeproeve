import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: const Text('Climbing App'),
        backgroundColor: topBackgroundColor,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 26,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Settings:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: topBackgroundColor,
                    ),
                    child: const Text('Logout'),
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 200,
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
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Delete account'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                            'WARNING - \nTHIS WILL DELETE ALL YOUR DATA'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              print('Confirmed deleting');
                              await _auth.signOut();
                              Navigator.pop(context); // Close the AlertDialog
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                            ),
                            child: const Text('Confirm'),
                          ),
                          TextButton(
                            onPressed: () {
                              print('Cancel deleting');
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                            ),
                            child: const Text('Cancel'),
                          ),
                        ],
                      );
                    },
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
