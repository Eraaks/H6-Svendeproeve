import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:svendeproeve_klatreapp/flows/home/home_page.dart';
import 'package:svendeproeve_klatreapp/flows/user/overview/user_overview_page.dart';
import 'package:svendeproeve_klatreapp/flows/user/rankings/user_rankings_page.dart';
import 'package:svendeproeve_klatreapp/flows/user/tips&tricks/user_tips_tricks_page.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({Key? key}) : super(key: key);

  @override
  State<NavBarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavBarPage> {
  int currentIndex = 0;
  final screens = [
    TipsTricksPage(),
    OverviewPage(),
    HomePage(),
    RankingPage(),
    //ProfilePage(),
  ];

  // final db = FirebaseFirestore.instance;
  // final SideMenu _sideMenu = SideMenu();

  @override
  Widget build(BuildContext context) => Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: buildBottomNavigationBar());

  Widget buildBottomNavigationBar() {
    final inactiveColor = Colors.grey;
    return BottomNavyBar(
        showElevation: true,
        itemCornerRadius: 16,
        containerHeight: 60,
        selectedIndex: currentIndex,
        onItemSelected: (index) => setState(() => currentIndex = index),
        backgroundColor: Colors.black,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: const Icon(Icons.live_help_outlined),
              title: const Text('Tips & Exercises'),
              activeColor: Colors.blue,
              inactiveColor: inactiveColor,
              textAlign: TextAlign.center),
          BottomNavyBarItem(
            icon: const Icon(Icons.map_outlined),
            title: const Text('Map'),
            activeColor: Colors.teal,
            inactiveColor: inactiveColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              activeColor: Color.fromRGBO(141, 110, 99, 1),
              inactiveColor: inactiveColor,
              textAlign: TextAlign.center),
          BottomNavyBarItem(
            icon: const Icon(Icons.format_list_numbered),
            title: const Text('Rankings'),
            activeColor: Colors.green,
            inactiveColor: inactiveColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
            activeColor: Colors.orangeAccent,
            inactiveColor: inactiveColor,
            textAlign: TextAlign.center,
          ),
        ]);
  }
}
