import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/user/rankings/widgets/person_page_widget.dart';

class PersonPage extends StatefulWidget {
  final String email;
  final String userUID;
  final bool following;
  final String selectedGym;
  const PersonPage(
      {super.key,
      required this.email,
      required this.userUID,
      required this.following,
      required this.selectedGym});

  @override
  State<PersonPage> createState() => _PersonPageState(
      email: email,
      userUID: userUID,
      following: following,
      selectedGym: selectedGym);
}

class _PersonPageState extends State<PersonPage> {
  final String email;
  final String userUID;
  final bool following;
  final String selectedGym;

  _PersonPageState(
      {required this.email,
      required this.userUID,
      required this.following,
      required this.selectedGym});

  @override
  Widget build(BuildContext context) => Scaffold(
          body: PersonPageWidget(
        email: email,
        userUID: userUID,
        following: following,
        selectedGym: selectedGym,
      ));
}
