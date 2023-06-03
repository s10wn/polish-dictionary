import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class WordItem extends StatelessWidget {
  const WordItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("word item"),
    );
  }
}
