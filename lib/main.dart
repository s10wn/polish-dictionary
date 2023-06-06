import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:polish_dictionary/presentation/screens/favorite-screen.dart';
import 'package:polish_dictionary/presentation/screens/home-screen.dart';
import 'package:polish_dictionary/presentation/screens/main-screen.dart';
import 'package:polish_dictionary/presentation/screens/setting-screen.dart';
import 'package:polish_dictionary/presentation/screens/welcome-screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _currentIndex = 0;
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Polish Dictionary",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(),
    );
  }
}
