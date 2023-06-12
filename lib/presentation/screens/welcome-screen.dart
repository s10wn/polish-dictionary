import 'package:flutter/material.dart';
import 'package:polish_dictionary/data/repositories/SharedPreferencesRepository.dart';
import 'package:polish_dictionary/domain/repositories/DataRepository.dart';
import 'package:polish_dictionary/presentation/screens/main-screen.dart';
import 'package:polish_dictionary/presentation/widgets/welcome-widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future<bool> shouldShowWelcomeScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();
    for (String key in keys) {
      dynamic value = prefs.get(key);
      print('$key: $value');
    }
    return prefs.getBool('welcome') ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: shouldShowWelcomeScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Ошибка');
        } else {
          bool showWelcomeScreen = snapshot.data ?? true;
          if (showWelcomeScreen) {
            return WelcomeWidget();
          } else {
            return MainScreen();
          }
        }
      },
    );
  }
}
