import 'package:flutter/material.dart';
import 'package:polish_dictionary/presentation/screens/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Polish Dictionary'),
          ),
          body: HomeScreen(),
        )),
  );
}
