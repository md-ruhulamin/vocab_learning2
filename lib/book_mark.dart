import 'package:flutter/material.dart';
import 'package:vocab_learning/controller/word_controller.dart';
import 'package:vocab_learning/wordModel.dart';

class BookMarkWIdget extends StatelessWidget {
  BookMarkWIdget({
    super.key,
    required this.realIndex,
    required this.word,
    required this.onTap,
  });

  final int realIndex;
  final VoidCallback onTap;
  final Word word;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        word.isBookmarked ? Icons.bookmark : Icons.bookmark_add_outlined,
        size: 20,
        color: Colors.blue.shade800,
      ),
    );
  }
}
