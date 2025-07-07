import 'package:flutter/material.dart';
import 'package:vocab_learning/controller/word_controller.dart';
import 'package:vocab_learning/widget/custom_text.dart';
import 'package:vocab_learning/wordModel.dart';

class AddtoDictionaryButton extends StatelessWidget {
  const AddtoDictionaryButton({
    super.key,
    required this.word,
    required this.controller,
  });

  final Word word;
  final WordController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title:
                    CustomText(text: "Add Word"),
                content: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    children: [
                      const TextSpan(
                          text:
                              "Do you want to add the word "),
                      TextSpan(
                        text: word.word,
                        style: const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const TextSpan(
                        text:
                            " in your list? You can change the meaning or add a new synonyms / antonyms",
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.addWord(word);
                      Navigator.pop(context);
                    },
                    child: Text("Save"),
                  ),
                ],
              );
            });
      },
      child: Icon(
        Icons.add_box_outlined,
        size: 20,
        color: Colors.blue.shade800,
      ),
    );
  }
}
