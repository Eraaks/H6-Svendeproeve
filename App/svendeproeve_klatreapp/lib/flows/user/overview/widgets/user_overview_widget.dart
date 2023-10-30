import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_side_bar/app_side_bar.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';

final AuthService _auth = AuthService();
final Sidebar _Sidebar = Sidebar();

class OverviewWidgets extends StatefulWidget {
  const OverviewWidgets({Key? key}) : super(key: key);

  @override
  State<OverviewWidgets> createState() => _OverviewWidgetsState();
}

class _OverviewWidgetsState extends State<OverviewWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: reusableAppBar(),
      drawer: _Sidebar,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Table(
            columnWidths: {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
            },
            border: TableBorder.all(),
            children: [
              buildRow(['Header1', 'Header2'], isHeader: true),
              buildRow(['Dummy1', 'Dummy1']),
              buildRow(['Dummy1', 'Dummy1']),
              buildRow(['Dummy1', 'Dummy1']),
            ],
          ),
        ),
      ),
    );
  }

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
        children: cells.map(
          (cell) {
            final style = TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              fontSize: 18,
            );

            return Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Text(cell, style: style),
              ),
            );
          },
        ).toList(),
      );
}
