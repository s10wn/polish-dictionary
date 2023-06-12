import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polish_dictionary/data/repositories/SharedPreferencesRepository.dart';
import 'package:polish_dictionary/domain/models/WordItem.dart';
import 'package:polish_dictionary/domain/repositories/DataRepository.dart';

class WordListWidget extends StatefulWidget {
  final Word wordList;

  const WordListWidget({
    super.key,
    required this.wordList,
  });

  @override
  State<WordListWidget> createState() => _WordListWidgetState();
}

class _WordListWidgetState extends State<WordListWidget> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  final DataRepository repository = SharedPreferencesRepository();

  @override
  void initState() {
    setState(() {
      isPlaying = widget.wordList.isPlaying;
    });
    super.initState();
  }

  Future setAudio(String audio) async {
    if (audio.isNotEmpty) {
      print(audio);
      audioPlayer.setReleaseMode(ReleaseMode.release);
      await audioPlayer.setSourceAsset(audio);
    }
  }

  @override
  void dispose() async {
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void toggleFavorite() async {
      setState(() {
        widget.wordList.isFavorite = !widget.wordList.isFavorite;
      });
      await repository.updateFavoriteState(
          widget.wordList.id, widget.wordList.isFavorite);
    }

    void playSound() async {
      await repository.updatePlayingState(widget.wordList.id, isPlaying);
      setAudio(widget.wordList.sound);
      audioPlayer.onPlayerStateChanged.listen((event) {
        setState(() {
          isPlaying = event == PlayerState.playing;
        });
      });
      if (isPlaying) {
        await audioPlayer.pause();
      } else {
        await audioPlayer.resume();
      }
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              CupertinoButton(
                onPressed: () => playSound(),
                child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.wordList.word,
                      style: GoogleFonts.roboto(
                          fontSize: 20, fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.wordList.translation,
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CupertinoButton(
                onPressed: () => toggleFavorite(),
                child: Icon(
                  widget.wordList.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1.2,
        ),
      ],
    );
  }
}
