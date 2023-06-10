import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polish_dictionary/data/repositories/SharedPreferencesRepository.dart';
import 'package:polish_dictionary/domain/models/WordItem.dart';
import 'package:polish_dictionary/domain/repositories/DataRepository.dart';
import 'package:polish_dictionary/presentation/screens/card-screen.dart';

class CardCategory extends StatefulWidget {
  const CardCategory({Key? key}) : super(key: key);

  @override
  State<CardCategory> createState() => _CardCategoryState();
}

class _CardCategoryState extends State<CardCategory> {
  List<List<Word>> wordsList = [];
  List<String> uniqueCategories = [];
  final DataRepository repository = SharedPreferencesRepository();

  Future<List<String>> setCategory() async {
    List<Word> loadedWords = await repository.loadData();
    // Получаем список уникальных категорий
    uniqueCategories =
        loadedWords.map((word) => word.category).toSet().toList();

    // Сохраняем отфильтрованные списки слов для каждой категории
    for (String category in uniqueCategories) {
      List<Word> filteredWords =
          loadedWords.where((word) => word.category == category).toList();
      // Сохраняем список слов для каждой категории
      wordsList.add(filteredWords);
    }

    return uniqueCategories;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: FutureBuilder(
          future: setCategory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Показываем индикатор загрузки
            } else if (snapshot.hasError) {
              return Text(
                  'Error: ${snapshot.error}'); // Показываем сообщение об ошибке, если есть
            } else {
              return Wrap(
                spacing: 8, // Отступ между контейнерами
                runSpacing: 8, // Отступ между строками
                children: List.generate(uniqueCategories.length, (index) {
                  double containerWidth =
                      (MediaQuery.of(context).size.width - 16) / 3 - 8;
                  return Container(
                    color: Color.fromARGB(255, 181, 181, 181),
                    height: 130,
                    width: containerWidth,
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CardScreen(
                              wordList: wordsList[
                                  index], // Передаем отфильтрованный список слов для выбранной категории
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            uniqueCategories[index],
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            uniqueCategories[index],
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            }
          },
        ),
      ),
    );
  }
}
