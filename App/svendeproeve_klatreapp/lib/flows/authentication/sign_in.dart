import 'dart:math';

import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';

class SignInPage extends StatelessWidget {
  final Function toggleView;
  const SignInPage({Key? key, required this.toggleView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: const Text('Sign In for Climbing App'),
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('Sign Up'),
              onPressed: () {
                toggleView();
              },
            ),
          ],
        ),
        body: Center(
            child: isSmallScreen
                ? const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _Logo(),
                      _SignInPageContent(),
                    ],
                  )
                : Container(
                    padding: const EdgeInsets.all(32.0),
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: const Row(
                      children: [
                        Expanded(child: _Logo()),
                        Expanded(
                          child: Center(child: _SignInPageContent()),
                        ),
                      ],
                    ),
                  )));
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FlutterLogo(size: isSmallScreen ? 100 : 200),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Welcome to Flutter!",
            textAlign: TextAlign.center,
            style: isSmallScreen
                ? Theme.of(context).textTheme.headlineSmall
                : Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }
}

class _SignInPageContent extends StatefulWidget {
  const _SignInPageContent({Key? key}) : super(key: key);

  @override
  State<_SignInPageContent> createState() => __SignInPageContentState();
}

class __SignInPageContentState extends State<_SignInPageContent> {
  bool _isPasswordVisible = false;
  final AuthService _auth = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              validator: (value) {
                // add email validation
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (!emailValid) {
                  return 'Please enter a valid email';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            _gap(),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }

                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            _gap(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    /// do something
                    dynamic result =
                        await _auth.signInWithEmailAndPassword(email, password);

                    if (result == null) {
                      setState(() {
                        error = 'Could not sign in with those credentials';
                      });
                    }
                  }
                },
              ),
            ),
            _gap(),
            FloatingActionButton.extended(
              onPressed: () async {
                await _auth.resetPassword(email: email);
                setState(() {
                  error = 'Password reset email sent';
                });
              },
              label: const Text('Forgot Password'),
            ),
            const SizedBox(height: 12.0),
            Text(
              error,
              style: const TextStyle(color: Colors.red, fontSize: 14.0),
            )
          ],
        ),
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}
