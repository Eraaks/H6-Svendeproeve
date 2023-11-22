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

Map<String, Color> colorMap = {
  'Color red': const Color.fromARGB(255, 255, 0, 0),
  'Color blue': const Color.fromARGB(255, 0, 68, 255),
  'Color green': const Color.fromARGB(255, 0, 255, 0),
  'Color black': const Color.fromARGB(255, 0, 0, 0),
  'Color yellow': const Color.fromARGB(255, 255, 251, 0),
  'Color light blue': const Color.fromARGB(255, 0, 225, 255),
  'Color Orange': const Color.fromARGB(255, 255, 145, 0),
};
