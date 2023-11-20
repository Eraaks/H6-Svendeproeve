import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:svendeproeve_klatreapp/flows/authentication/widgets/authentication_wrapper.dart';
import 'package:svendeproeve_klatreapp/flows/reusable/restart_app.dart';
import 'package:svendeproeve_klatreapp/models/user.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';
import 'firebase_options.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(RestartWidget(child: const MyApp()));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserClass?>.value(
      value: AuthService().user,
      catchError: (context, error) {
        print('Context: $context');
        print('Error: $error');
        return null;
      },
      initialData: null,
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
