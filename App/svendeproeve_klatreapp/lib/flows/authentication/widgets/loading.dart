import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_nav_bar/app_nav_bar.dart';
import 'package:svendeproeve_klatreapp/flows/moderator/overview/moderator_overview_page.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/models/profile_data.dart';
import 'package:svendeproeve_klatreapp/services/klatreapp_api_service.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  final APIService _apiService = APIService();
  late Future<TokenResult> tokenFetched;

  @override
  void initState() {
    super.initState();
    tokenFetched = _apiService.getFirebaseSecret();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<TokenResult>(
      future: tokenFetched,
      builder: (BuildContext context, AsyncSnapshot<TokenResult> snapshot) {
        if (!snapshot.hasData) {
          // while data is loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.success == true) {
          // data loaded:
          // set Moderator = True in Constants to test Mod page.
          String selectedGym = snapshot.data!.selectedGym;
          return isModerator
              ? const ModOverviewPage()
              : NavBarPage(SelectedGym: selectedGym);
        } else {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    ));
  }
}
