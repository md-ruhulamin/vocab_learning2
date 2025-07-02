import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocab_learning/controller.dart';
import 'package:vocab_learning/custome_text_filed.dart';
import 'package:vocab_learning/wordModel.dart';

class AddWordPage extends StatelessWidget {
  final WordController controller = Get.put(WordController());

  final wordController = TextEditingController();
  final meaningController = TextEditingController();
  final synonymController = TextEditingController();
  final antonymController = TextEditingController();
  final sentenceController = TextEditingController();

  void addWord() {
    if (wordController.text.isNotEmpty && meaningController.text.isNotEmpty) {
      final word = Word(
        id: DateTime.now().millisecondsSinceEpoch, // Unique ID based on timestamp
        word: wordController.text.trim(),
        meaning: meaningController.text.trim(),
        synonyms: synonymController.text.isNotEmpty
            ? synonymController.text.split(',').map((e) => e.trim()).toList()
            : [],
        antonyms: antonymController.text.isNotEmpty
            ? antonymController.text.split(',').map((e) => e.trim()).toList()
            : [],
        sentences: sentenceController.text.isNotEmpty
            ? sentenceController.text.split('|').map((e) => e.trim()).toList()
            : [],
      );

      controller.addWord(word);
      wordController.clear();
      meaningController.clear();
      synonymController.clear();
      antonymController.clear();
      sentenceController.clear();
    } else {
      Get.snackbar("Failed", "Word or Meaning cann't be empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Vocabulary App')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            CustomTextField(
              controller: wordController,
              hintText: 'Word',
            ),
            CustomTextField(
              controller: meaningController,
              hintText: 'Meaning',
            ),
            CustomTextField(
                hintText: 'Synonyms (comma separated)',
                controller: synonymController),
            CustomTextField(
                controller: antonymController,
                hintText: 'Antonyms (comma separated)'),
            CustomTextField(
                maxLines: 3,
                controller: sentenceController,
                hintText: 'Sentences (separate by |)'),
            SizedBox(height: 10),
            ElevatedButton(onPressed: addWord, child: Text('Add Word')),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
