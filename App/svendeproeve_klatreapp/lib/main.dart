import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svendeproeve_klatreapp/flows/authentication/widgets/authentication_wrapper.dart';
import 'package:svendeproeve_klatreapp/models/user.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
