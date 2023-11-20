import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/flows/authentication/register.dart';
import 'package:svendeproeve_klatreapp/flows/authentication/register2.dart';
import 'package:svendeproeve_klatreapp/flows/authentication/sign_in.dart';
import 'package:svendeproeve_klatreapp/flows/authentication/sign_in2.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInPage(toggleView: toggleView);
    } else {
      return SignUpPage(
        toggleView: toggleView,
      );
      // return Register(toggleView: toggleView);
    }
  }
}
