import 'package:flutter/material.dart';
import 'package:polish_dictionary/data/repositories/SharedPreferencesRepository.dart';
import 'package:polish_dictionary/domain/repositories/DataRepository.dart';
import 'package:polish_dictionary/presentation/screens/main-screen.dart';
import 'package:polish_dictionary/presentation/widgets/welcome-widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future<void> setWord() async {
    DataRepository repository = SharedPreferencesRepository();
    for (int i = 0; i < 10; i++) {
      String sound = 'звук_$i';
      String word = 'слово_$i';
      String category = (i % 2 == 0) ? 'Категория A' : 'Категория B';
      int id = i;
      String translation = 'Перевод $i';

      await repository.addWord(sound, word, category, id, translation);
    }
  }

  Future<bool> shouldShowWelcomeScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();

    setWord();
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
