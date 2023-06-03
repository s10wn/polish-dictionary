import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polish_dictionary/presentation/widgets/word-item.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  var _currentIndex = 0;
  late TextEditingController controller;
  final ScrollController _firstController = ScrollController();

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
        child: Scrollbar(
          thumbVisibility: true,
          controller: _firstController,
          child: ListView.builder(
              physics: ClampingScrollPhysics(),
              controller: _firstController,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          CupertinoButton(
                              child: const Icon(Icons.volume_up),
                              onPressed: () => {}),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Polish Word",
                                  style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "English Word",
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1.2,
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
