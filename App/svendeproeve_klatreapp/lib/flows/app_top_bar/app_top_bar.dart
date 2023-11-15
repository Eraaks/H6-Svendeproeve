import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:svendeproeve_klatreapp/flows/settings/settings_page.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';

final AuthService _auth = AuthService();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
          onPressed: () async {
            await _auth.signOut();
          },
        ),
      ],
    ),
  );
}
