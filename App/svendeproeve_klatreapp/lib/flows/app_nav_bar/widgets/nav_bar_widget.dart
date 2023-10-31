import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/home/home_page.dart';
import 'package:svendeproeve_klatreapp/flows/user/overview/user_overview_page.dart';
import 'package:svendeproeve_klatreapp/flows/user/personal/user_personal_page.dart';
import 'package:svendeproeve_klatreapp/flows/user/rankings/user_rankings_page.dart';
import 'package:svendeproeve_klatreapp/flows/user/tips&tricks/user_tips_tricks_page.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';

final AuthService _auth = AuthService();
final Sidebar _Sidebar = Sidebar();

class NavBarWidgets extends StatefulWidget {
  const NavBarWidgets({Key? key}) : super(key: key);

  @override
  State<NavBarWidgets> createState() => _NavBarWidgetsState();
}

class _NavBarWidgetsState extends State<NavBarWidgets> {
  int currentIndex = 2;
  final screens = [
    const TipsTricksPage(),
    const OverviewPage(),
    const HomePage(),
    const RankingsPage(),
    const PersonalPage(),
  ];

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
            title: const Text('Overview'),
            activeColor: Colors.teal,
            inactiveColor: inactiveColor,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              activeColor: topBackgroundColor,
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
