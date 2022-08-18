import 'dart:convert';

import '../main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final pref = SharedPreferences.getInstance();
  bool eye = true;

  bool _checkVal = false;

  void _submit() async {
    if (_errorText == null && _errorUserText == null) {
      try {
        final _auth = FirebaseAuth.instance;

        UserCredential currentUser = await _auth.signInWithEmailAndPassword(
            email: usernameController.text, password: passwordController.text);
      } catch (e) {
        var snackBar = SnackBar(
          duration: const Duration(milliseconds: 1500),
          content:
              Text('${e.toString().replaceRange(0, 14, '').split(']')[1]}'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  String? get _errorUserText {
    if (usernameController.value.text.isEmpty) {
      return "Can't be empty";
    }
    return null;
  }

  String? get _errorText {
    if (passwordController.value.text.isEmpty) {
      return "Can't be empty";
    }
    return null;
  }

  bool check = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _text = '';
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: (Row(
            children: [
              Row(
                children: [
                  IconButton(
                    splashRadius: 20,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          )),
        ),
        backgroundColor: Colors.white,
        body: Center(
            child: Stack(children: [
          SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Image.asset(
                  'images/messenger.png',
                  scale: 1,
                  width: 80,
                ),
                const SizedBox(
                  height: 50,
                ),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    errorText: _checkVal ? _errorUserText : null,
                    prefixIcon: const Icon(
                      Icons.email_rounded,
                    ),
                    hintText: "Enter your Email Address",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                          width: 1, color: Color.fromARGB(255, 177, 177, 177)),
                    ),
                  ),
                  onChanged: (text) => setState(() => _text),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: eye,
                  decoration: InputDecoration(
                      errorText: _checkVal ? _errorText : null,
                      hintText: "Enter your password",
                      prefixIcon: const Icon(
                        Icons.key,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: const BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 177, 177, 177)),
                      ),
                      suffixIcon: IconButton(
                          splashRadius: 5,
                          iconSize: 20,
                          onPressed: () {
                            setState(() {
                              eye = !eye;
                            });
                          },
                          icon: eye
                              ? const Icon(
                                  Icons.remove_red_eye,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                ))),
                  onChanged: (text) => setState(() => _text),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            setState(() {
                              if (_checkVal == true) {
                                _submit();
                              } else {
                                _checkVal = true;
                              }
                            });
                          });
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ))),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account yet?",
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signUp');
                      },
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
        ])),
      ),
    );
  }
}
