import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:polish_dictionary/data/repositories/SharedPreferencesRepository.dart';
import 'package:polish_dictionary/domain/models/WordItem.dart';
import 'package:polish_dictionary/domain/repositories/DataRepository.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final DataRepository repository = SharedPreferencesRepository();
  Timer? _timer;
  List<Word> favoriteWords = [];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateFavoriteWords();
    });
  }

  void cancelTimer() {
    // Отменяем таймер, если он был создан
    _timer?.cancel();
  }

  Future<void> updateFavoriteWords() async {
    List<Word> updatedFavoriteWords = await repository.getFavoriteWords();
    setState(() {
      favoriteWords = updatedFavoriteWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoriteWords.length,
      itemBuilder: (context, index) {
        Word word = favoriteWords[index];
        return Card(
          child: ListTile(
            title: Text(word.word),
            subtitle: Text(word.translation),
            trailing: IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () async {
                setState(() {
                  word.isFavorite = !word.isFavorite;
                });
                await repository.updateFavoriteState(word.id, word.isFavorite);
              },
            ),
          ),
        );
      },
    );
  }
}
