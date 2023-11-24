import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/widgets/side_bar_widget.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) => const Scaffold(body: SidebarWidgets());
}
