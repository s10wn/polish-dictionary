import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:polish_dictionary/data/repositories/SharedPreferencesRepository.dart';
import 'package:polish_dictionary/domain/repositories/DataRepository.dart';
import 'package:polish_dictionary/presentation/screens/favorite-screen.dart';
import 'package:polish_dictionary/presentation/screens/home-screen.dart';
import 'package:polish_dictionary/presentation/screens/main-screen.dart';
import 'package:polish_dictionary/presentation/screens/setting-screen.dart';
import 'package:polish_dictionary/presentation/screens/welcome-screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация репозитория данных
  DataRepository repository = SharedPreferencesRepository();

  bool isDataAdded = await repository.isDataAdded();

  if (!isDataAdded) {
    String jsonData = await rootBundle.loadString('assets/data.json');
    List<dynamic> wordDataList = jsonDecode(jsonData);

    for (dynamic wordData in wordDataList) {
      String sound = wordData['sound'];
      String word = wordData['word'];
      String categoryIcon = wordData['categoryIcon'];
      String category = wordData['category'];
      int id = wordData['id'];
      String translation = wordData['translation'];
      await repository.addWord(
          sound, word, categoryIcon, category, id, translation);
    }

    await repository
        .setDataAdded(true); // Установка флага, что данные были добавлены
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Polish Dictionary",
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(),
    );
  }
}
