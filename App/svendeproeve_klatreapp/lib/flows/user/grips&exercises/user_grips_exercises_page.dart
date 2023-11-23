import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/flows/user/grips&exercises/widgets/user_grips_exercises_widget.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';

class TipsTricksPage extends StatefulWidget {
  const TipsTricksPage({Key? key}) : super(key: key);

  @override
  State<TipsTricksPage> createState() => _TipsTricksPageState();
}

class _TipsTricksPageState extends State<TipsTricksPage> {
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: TipsTricksWidgets());
}
