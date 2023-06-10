import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:polish_dictionary/data/repositories/SharedPreferencesRepository.dart';
import 'package:polish_dictionary/domain/models/WordItem.dart';
import 'package:polish_dictionary/domain/repositories/DataRepository.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final DataRepository repository = SharedPreferencesRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: repository.getFavoriteWords(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Ошибка');
        } else {
          List<Word> wordList = snapshot.data ?? [];
          return ListView.builder(
            itemCount: wordList.length,
            itemBuilder: (context, index) {
              Word word = wordList[index];
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
                      await repository.updateFavoriteState(
                          word.id, word.isFavorite);
                      setState(() {});
                    },
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
