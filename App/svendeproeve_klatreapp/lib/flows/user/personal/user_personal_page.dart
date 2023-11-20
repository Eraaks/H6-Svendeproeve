import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/user/personal/widgets/user_personal_widget.dart';

class PersonalPage extends StatefulWidget {
  final String selectedGym;
  const PersonalPage({Key? key, required this.selectedGym}) : super(key: key);

  @override
  State<PersonalPage> createState() =>
      _PersonalPageState(selectedGym: selectedGym);
}

class _PersonalPageState extends State<PersonalPage> {
  final String selectedGym;
  _PersonalPageState({required this.selectedGym});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: PersonalWidgets(selectedGym: selectedGym));
}
