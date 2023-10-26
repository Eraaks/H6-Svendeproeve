import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svendeproeve_klatreapp/flows/app_nav_bar/app_nav_bar.dart';
import 'package:svendeproeve_klatreapp/flows/authentication/authentication_page.dart';
import 'package:svendeproeve_klatreapp/models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass?>(context);

    // Return either home or authenticate widget
    if (user == null) {
      return const Authenticate();
    } else {
      return const NavBarPage();
    }
  }
}
