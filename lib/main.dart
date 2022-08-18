import 'package:flutter/material.dart';
import 'sing_up.dart';
import 'sing_up.dart';
import 'sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/signIn': (context) => const SignIn(),
        '/signUp': (context) => const SignUp(),
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: [
                Image.asset(
                  'images/messenger.png',
                  scale: 1,
                  width: 80,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Welcome to",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const Text("Messenger",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ],
            ),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(150, 40)),
                onPressed: () {
                  Navigator.pushNamed(context, '/signIn');
                },
                child: const Text('SIGN IN')),
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
                "SWITCH ACCOUNT",
              ),
            )
          ],
        ),
      ),
    );
  }
}
