import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_nav_bar/app_nav_bar.dart';
import 'package:svendeproeve_klatreapp/flows/moderator/overview/moderator_overview_page.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/models/climbing_center.dart';
import 'package:svendeproeve_klatreapp/models/profile_data.dart';
import 'package:svendeproeve_klatreapp/services/klatreapp_api_service.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  final APIService _apiService = APIService();
  late Future<TokenResult?> tokenFetched;

  @override
  void initState() {
    super.initState();
    tokenFetched = _apiService.getFirebaseSecret();
    //final isModerator = _apiService.checkIfUserModerator(tokenFetched)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<TokenResult?>(
      future: tokenFetched,
      builder: (BuildContext context, AsyncSnapshot<TokenResult?> snapshot) {
        if (!snapshot.hasData) {
          // while data is loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.success == true) {
          String selectedGym = snapshot.data!.selectedGym;
          print('Moderator?');
          print(snapshot.data!.isModerator);
          return snapshot.data!.isModerator
              ? ModOverviewPage(
                  selectedGym: selectedGym,
                  profileData: snapshot.data!.profileData)
              : NavBarPage(
                  selectedGym: selectedGym,
                  profileData: snapshot.data!.profileData);
        } else {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    ));
  }
}
