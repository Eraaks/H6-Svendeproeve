import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/user/grips&exercises/widgets/user_grips_exercises_widget.dart';

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
