import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/user/personal/widgets/user_personal_widget.dart';
import 'package:svendeproeve_klatreapp/models/profile_data.dart';

class PersonalPage extends StatefulWidget {
  final String SelectedGym;
  final ProfileData profileData;
  const PersonalPage(
      {Key? key, required this.SelectedGym, required this.profileData})
      : super(key: key);

  @override
  State<PersonalPage> createState() =>
      _PersonalPageState(SelectedGym: SelectedGym, profileData: profileData);
}

class _PersonalPageState extends State<PersonalPage> {
  final String SelectedGym;
  final ProfileData profileData;
  _PersonalPageState({required this.SelectedGym, required this.profileData});
  @override
  Widget build(BuildContext context) => Scaffold(
      body:
          PersonalWidgets(SelectedGym: SelectedGym, profileData: profileData));
}
