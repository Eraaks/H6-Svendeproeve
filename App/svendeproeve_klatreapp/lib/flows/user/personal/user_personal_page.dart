import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/user/personal/widgets/user_personal_widget.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) => const Scaffold(body: PersonalWidgets());
}
