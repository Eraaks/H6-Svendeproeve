import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';

class SidebarWidgets extends StatefulWidget {
  const SidebarWidgets({Key? key}) : super(key: key);

  @override
  State<SidebarWidgets> createState() => _SidebarWidgetsState();
}

class _SidebarWidgetsState extends State<SidebarWidgets> {
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
      color: Colors.brown[400],
      padding: EdgeInsets.only(
        top: 15 + MediaQuery.of(context).padding.top,
        bottom: 15,
      ),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back,
          size: 26,
          color: Colors.white,
        ),
      ));
  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Boulder'),
              onTap: () {},
            ),
            ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Beta Boulders'),
                onTap: () {}),
          ],
        ),
      );
}
