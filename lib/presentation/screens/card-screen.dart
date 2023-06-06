import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polish_dictionary/data/repositories/dataRepository.dart';
import 'package:polish_dictionary/domain/models/WordItem.dart';
import 'package:polish_dictionary/domain/repositories/sharedDataRepository.dart';
import 'package:polish_dictionary/presentation/widgets/word.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;
    DataRepository repository = SharedPreferencesRepository();

    void addWord() async {
      List<WordItem> wordList = await repository.loadData();

      // Создаем новое слово
      WordItem newWord = WordItem(
        sound: 'sound4.mp3',
        text: 'zxczxc',
        translate: 'Пример',
      );

      // Проверяем наличие нового слова в списке
      bool wordExists = wordList.any((word) => word.text == newWord.text);

      if (!wordExists) {
        // Добавляем новое слово только если оно не существует в списке
        wordList.add(newWord);
        await repository.saveData(wordList);
        debugPrint(wordList.toString());
      } else {
        debugPrint('Слово уже существует в списке');
      }
    }

    return Scaffold(
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
                // isBackButtonVisible: false,
                backIconColor: Colors.black,
                centerTitle: 'POLISH',
                onChanged: (text) {
                  print(text);
                },
                searchTextEditingController: controller,
                horizontalPadding: 5),
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<WordItem>>(
          future: repository.loadData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Отображаем индикатор загрузки, пока данные загружаются
            } else if (snapshot.hasError) {
              return Text(
                  'Ошибка загрузки данных'); // Выводим сообщение об ошибке, если произошла ошибка загрузки
            } else {
              List<WordItem> wordList = snapshot.data ?? [];
              return WordListWidget(
                wordList: wordList,
                repository: repository,
              ); // Отображаем список слов с помощью WordListWidget
            }
          },
        ),
      ),
    );
  }
}
