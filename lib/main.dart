import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:polish_dictionary/presentation/screens/favorite-screen.dart';
import 'package:polish_dictionary/presentation/screens/home-screen.dart';
import 'package:polish_dictionary/presentation/screens/setting-screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static const title = 'Polish Dictionary';

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
      title: MyApp.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 65),
          child: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: AnimationSearchBar(
                  isBackButtonVisible: false,
                  backIconColor: Colors.black,
                  centerTitle: 'App Title',
                  onChanged: (text) {
                    print(text);
                  },
                  searchTextEditingController: controller,
                  horizontalPadding: 5),
            ),
          ),
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomeScreen(),
            FavoriteScreen(),
            SettingScreen(),
          ],
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
              selectedColor: Colors.purple,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.favorite_border),
              title: const Text("Likes"),
              selectedColor: Colors.pink,
            ),
            SalomonBottomBarItem(
              icon: const Icon(Icons.settings),
              title: const Text("Settings"),
              selectedColor: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}