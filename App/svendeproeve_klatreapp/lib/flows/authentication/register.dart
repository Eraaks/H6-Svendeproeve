import 'package:flutter/material.dart';
import 'package:svendeproeve_klatreapp/global/constants.dart';
import 'package:svendeproeve_klatreapp/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign Up for Climbing App'),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person),
            label: const Text('Sign In'),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration:
                    textInputDecoration.copyWith(hintText: 'Enter a email'),
                validator: (value) => value!.isEmpty ? 'Enter an email' : null,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration:
                    textInputDecoration.copyWith(hintText: 'Enter a password'),
                obscureText: true,
                validator: (value) => value!.length < 6
                    ? 'Enter an password 6+ chars long'
                    : null,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Please supply a valid email';
                        isLoading = false;
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 12.0),
              Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
