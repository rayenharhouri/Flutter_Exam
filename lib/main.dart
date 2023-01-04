import 'package:flutter/material.dart';

import 'Home/nav_tab.dart';
import 'auth/signIn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      title: "Pharmacie",
      routes: {
        "/": (context) => const SignIn(),
        "/home" :(context) => const NavigationTab(),
      },

    );
  }
}
