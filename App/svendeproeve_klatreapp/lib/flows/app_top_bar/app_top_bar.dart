import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:svendeproeve_klatreapp/flows/settings/settings_page.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';

final AuthService _auth = AuthService();

PreferredSize reusableAppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(56),
    child: AppBar(
      title: Text('Climbing App'),
      backgroundColor: topBackgroundColor,
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.settings,
            color: mainBackgroundColor,
          ),
          onPressed: () {
            //navigate();
          },
        ),
      ],
    ),
  );
}

// void navigate() {
//   print('Navigate');
//   navigatorKey.currentState?.push(MaterialPageRoute(
//     builder: (context) => SettingsPage(),
//   ));
// }
