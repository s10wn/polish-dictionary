import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polish_dictionary/data/repositories/SharedPreferencesRepository.dart';
import 'package:polish_dictionary/domain/models/WordItem.dart';
import 'package:polish_dictionary/domain/repositories/DataRepository.dart';
import 'package:polish_dictionary/presentation/widgets/word.dart';

class CardScreen extends StatefulWidget {
  CardScreen({super.key, required this.wordList});
  List<Word> wordList;
  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  late TextEditingController controller;
  final DataRepository repository = SharedPreferencesRepository();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
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
        child: ListView.builder(
          itemCount: widget.wordList.length,
          itemBuilder: (context, index) {
            return WordListWidget(
              wordList: widget.wordList[index],
            );
          },
        ),
      ),
    );
  }
}
