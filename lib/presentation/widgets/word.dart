import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polish_dictionary/data/repositories/dataRepository.dart';
import 'package:polish_dictionary/domain/models/WordItem.dart';

class WordListWidget extends StatelessWidget {
  final List<WordItem> wordList;
  final DataRepository repository;

  const WordListWidget({
    required this.wordList,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: wordList.length,
      itemBuilder: (context, index) {
        WordItem wordItem = wordList[index];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  CupertinoButton(
                      child: const Icon(Icons.volume_up), onPressed: () => {}),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(wordItem.text,
                          style: GoogleFonts.roboto(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        wordItem.translate,
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CupertinoButton(
                    child: Icon(
                      wordItem.favorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () => toggleFavorite(wordItem),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1.2,
            ),
          ],
        );
      },
    );
  }

  void toggleFavorite(WordItem wordItem) async {
    wordItem.favorite = !wordItem.favorite;
    await repository.saveData(wordList);
  }
}
