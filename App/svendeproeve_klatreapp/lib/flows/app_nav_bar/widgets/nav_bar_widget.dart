import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/home/home_page.dart';
import 'package:svendeproeve_klatreapp/flows/moderator/overview/moderator_overview_page.dart';
import 'package:svendeproeve_klatreapp/flows/settings/settings_page.dart';
import 'package:svendeproeve_klatreapp/flows/user/overview/user_overview_page.dart';
import 'package:svendeproeve_klatreapp/flows/user/personal/user_personal_page.dart';
import 'package:svendeproeve_klatreapp/flows/user/rankings/user_rankings_page.dart';
import 'package:svendeproeve_klatreapp/flows/user/grips&exercises/user_grips_exercises_page.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/models/profile_data.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';
import 'package:http/http.dart' as http;

final AuthService _auth = AuthService();

class NavBarWidgets extends StatefulWidget {
  final String selectedGym;
  final ProfileData profileData;
  final bool isModerator;
  const NavBarWidgets(
      {Key? key,
      required this.selectedGym,
      required this.profileData,
      required this.isModerator})
      : super(key: key);

  @override
  State<NavBarWidgets> createState() => _NavBarWidgetsState(
      selectedGym: selectedGym,
      profileData: profileData,
      isModerator: isModerator);
}

class _NavBarWidgetsState extends State<NavBarWidgets> {
  final String selectedGym;
  final ProfileData profileData;
  final bool isModerator;
  _NavBarWidgetsState(
      {required this.selectedGym,
      required this.profileData,
      required this.isModerator});

  int currentIndex = 2;
  late List<StatefulWidget> screens = [
    TipsTricksPage(),
    OverviewPage(selectedGym: selectedGym),
    HomePage(selectedGym: selectedGym),
    RankingsPage(selectedGym: selectedGym),
    PersonalPage(selectedGym: selectedGym, profileData: profileData),
  ];
  int moderatorIndex = 1;
  late List<StatefulWidget> moderatorScreens = [
    ModOverviewPage(
      selectedGym: selectedGym,
      profileData: profileData,
    ),
    HomePage(selectedGym: selectedGym),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
      body: IndexedStack(
        index: isModerator ? moderatorIndex : currentIndex,
        children: isModerator ? moderatorScreens : screens,
      ),
      bottomNavigationBar: isModerator
          ? buildModeratorBottomNavigationBar()
          : buildBottomNavigationBar());

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
              icon: const Icon(Icons.fitness_center),
              title: const Text('Exercises'),
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

  Widget buildModeratorBottomNavigationBar() {
    final inactiveColor = Colors.grey;
    return BottomNavyBar(
        showElevation: true,
        itemCornerRadius: 16,
        containerHeight: 60,
        selectedIndex: moderatorIndex,
        onItemSelected: (index) => setState(() => moderatorIndex = index),
        backgroundColor: Colors.black,
        items: <BottomNavyBarItem>[
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
        ]);
  }
}
