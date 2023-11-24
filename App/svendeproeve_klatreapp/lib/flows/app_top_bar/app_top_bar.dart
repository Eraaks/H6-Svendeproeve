import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/settings/settings_page.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';

class Topbar extends StatefulWidget implements PreferredSizeWidget {
  const Topbar({Key? key}) : super(key: key);

  @override
  State<Topbar> createState() => _TopbarState();

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _TopbarState extends State<Topbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Climb-IT'),
      backgroundColor: topBackgroundColor,
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.settings,
            color: mainBackgroundColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
