import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/user/personal/widgets/user_personal_widget.dart';

class PersonalPage extends StatefulWidget {
  final String SelectedGym;
  const PersonalPage({Key? key, required this.SelectedGym}) : super(key: key);

  @override
  State<PersonalPage> createState() =>
      _PersonalPageState(SelectedGym: SelectedGym);
}

class _PersonalPageState extends State<PersonalPage> {
  final String SelectedGym;
  _PersonalPageState({required this.SelectedGym});
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: PersonalWidgets(SelectedGym: SelectedGym));
}
