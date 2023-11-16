import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/app_nav_bar/app_nav_bar.dart';
import 'package:svendeproeve_klatreapp/models/profile_data.dart';
import 'package:svendeproeve_klatreapp/services/klatreapp_api_service.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  final APIService _apiService = APIService();
  late Future<bool> tokenFetched;

  @override
  void initState() {
    super.initState();
    tokenFetched = _apiService.getFirebaseSecret();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<bool>(
      future: tokenFetched,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          // while data is loading:
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data == true) {
          // data loaded:
          return const NavBarPage();
        } else {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    ));
  }
}
