import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/user/personal/widgets/user_personal_widget.dart';
import 'package:svendeproeve_klatreapp/models/profile_data.dart';

class PersonalPage extends StatefulWidget {
  final String selectedGym;
  final ProfileData profileData;
  const PersonalPage(
      {Key? key, required this.selectedGym, required this.profileData})
      : super(key: key);

  @override
  State<PersonalPage> createState() =>
      _PersonalPageState(selectedGym: selectedGym, profileData: profileData);
}

class _PersonalPageState extends State<PersonalPage> {
  final String selectedGym;
  final ProfileData profileData;
  _PersonalPageState({required this.selectedGym, required this.profileData});
  @override
  Widget build(BuildContext context) => Scaffold(
      body:
          PersonalWidgets(selectedGym: selectedGym, profileData: profileData));
}
