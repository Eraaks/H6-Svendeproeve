import 'package:flutter/material.dart';

const double fontsizeForTitles = 20;
const Color backgroundColorForSubpages = Color.fromRGBO(225, 232, 235, 100);
const Color mainBackgroundColor = Color.fromRGBO(239, 235, 233, 1);
const Color topBackgroundColor = Color.fromRGBO(141, 110, 99, 1);
const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);
const bool isModerator = true;

Map<String, Color> colorMap = {
  'Color red': Colors.red,
  'Color blue': Colors.blue,
  'Color green': Colors.green,
  'Color black': Colors.black,
  'Color yellow': Colors.yellow,
  'Color teal': Colors.teal,
  'Color purple': Colors.purple,
};
