import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool eye = true;
  bool _validate = false;

  String? get _errorText {
    final psstext = passwordController.value.text;

    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    if (psstext.isEmpty) {
      return "Can't be empty";
    }
    if (psstext.length < 6) {
      return "Password Must be more than 6 characters";
    }
    if (!regex.hasMatch(psstext)) {
      return "Password should contain upper,lower,digit and Special character ";
    }
    return null;
  }

  void _submit() async {
    if (_errorText == null && _errorUserText == null) {
      try {
        final _auth = FirebaseAuth.instance;

        final newUser = await _auth.createUserWithEmailAndPassword(
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
    final usertext = usernameController.value.text;

    if (usertext.isEmpty) {
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
        backgroundColor: Colors.transparent,
        body: Center(
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
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
                          errorText: _validate ? _errorUserText : null,
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
                                width: 1,
                                color: Color.fromARGB(255, 177, 177, 177)),
                          ),
                        ),
                        onChanged: (text) => setState(() {
                              _errorText;
                            })),
                    const SizedBox(
                      height: 40,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: eye,
                      decoration: InputDecoration(
                        errorText: _validate ? _errorText : null,
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
                                  )),
                      ),
                      onChanged: (text) => setState(() => _text),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                if (_validate == true) {
                                  _submit();
                                } else {
                                  _validate = true;
                                }
                              });
                            },
                            child: const Text(
                              'Create Account',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signIn');
                          },
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          child: const Text(
                            'Sign In',
                          ),
                        ),
                      ],
                    )
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
