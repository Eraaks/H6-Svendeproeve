import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';

final AuthService _auth = AuthService();

PreferredSize ReusableAppBar() {
  return PreferredSize(
      preferredSize: Size.fromHeight(56),
      child: AppBar(
        title: Text('Climbing App'),
        backgroundColor: Color.fromRGBO(141, 110, 99, 1),
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('Log Out'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ));
}
