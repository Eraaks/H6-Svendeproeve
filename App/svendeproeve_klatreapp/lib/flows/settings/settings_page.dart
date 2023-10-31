import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/settings/widgets/settings_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) => const Scaffold(body: SettingsWidgets());
}
