import 'package:flutter/material.dart';
import 'package:polish_dictionary/presentation/screens/main-screen.dart';
import 'package:polish_dictionary/presentation/widgets/welcome-widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future<bool> shouldShowWelcomeScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('welcome') ?? true;
  }

  Future<void> updateShowWelcomeScreen(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('welcomex', value);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: shouldShowWelcomeScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Ошибка загрузки данных');
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
