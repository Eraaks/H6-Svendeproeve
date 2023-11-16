import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_top_bar/app_top_bar.dart';
import 'package:svendeproeve_klatreapp/models/profile_data.dart';
import 'package:svendeproeve_klatreapp/services/klatreapp_api_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Reusable_Graph_Widget extends StatefulWidget {
  final String userUID;
  const Reusable_Graph_Widget({super.key, required this.userUID});

  @override
  State<Reusable_Graph_Widget> createState() =>
      _Reusable_Graph_WidgetState(userUID: userUID);
}

class _Reusable_Graph_WidgetState extends State<Reusable_Graph_Widget> {
  final String userUID;
  static final APIService _apiService = APIService();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<ProfileData>? profileData;

  final DateTime now = DateTime.now();
  final int dateMinusTwoMonths =
      DateTime.now().subtract(const Duration(days: 60)).millisecondsSinceEpoch;
  late List<SendCollections> data;

  _Reusable_Graph_WidgetState({required this.userUID});
  @override
  void initState() {
    super.initState();
    _initClimbingscore();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initClimbingscore() async {
    profileData = _apiService.getProfileData(userUID);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300, maxWidth: 400),
        child: FutureBuilder<ProfileData>(
          future: profileData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final climbing = snapshot.data!;
              data = climbing.climbingHistory!
                  .firstWhere(
                    (element) => element.location == 'BetaBouldersSouth',
                  )
                  .sendCollections!
                  .where((element) => element.sendDate! >= dateMinusTwoMonths)
                  .toList();

              data = data..sort((a, b) => a.sendDate!.compareTo(b.sendDate!));
              //Initialize the chart widget
              return SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(text: 'Grade Progression'),
                  // Enable legend
                  // legend: const Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<SendCollections, String>>[
                    SplineSeries<SendCollections, String>(
                        dataSource: data,
                        xValueMapper: (SendCollections sales, _) =>
                            'Month ' +
                            DateTime.fromMicrosecondsSinceEpoch(sales.sendDate!)
                                .month
                                .toString(),
                        yValueMapper: (SendCollections sales, _) =>
                            sales.points,
                        // name: 'Grade Progression',
                        // Enable data label
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false))
                  ]);
            }
          },
        ));
  }
}
