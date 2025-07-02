import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocab_learning/controller.dart';
import 'package:vocab_learning/custome_text_filed.dart';
import 'package:vocab_learning/wordModel.dart';

class EditWordPage extends StatelessWidget {
  final Word word;
  final int index;

  EditWordPage({required this.word, required this.index});

  final controller = Get.find<WordController>();
  final wordCtrl = TextEditingController();
  final meaningCtrl = TextEditingController();
  final synonymCtrl = TextEditingController();
  final antonymCtrl = TextEditingController();
  final sentenceCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    wordCtrl.text = word.word;
    meaningCtrl.text = word.meaning;
    synonymCtrl.text = word.synonyms.join(', ');
    antonymCtrl.text = word.antonyms.join(', ');
    sentenceCtrl.text = word.sentences.join('| ');

    void update() {
      if (meaningCtrl.text.isNotEmpty && wordCtrl.text.isNotEmpty) {
        final updated = Word(
          id: word.id, // Assuming id is part of the Word model
          word: wordCtrl.text,
          meaning: meaningCtrl.text,
          synonyms: synonymCtrl.text.isNotEmpty
              ? synonymCtrl.text.split(',').map((e) => e.trim()).toList()
              : [],
          antonyms: antonymCtrl.text.isNotEmpty
              ? antonymCtrl.text.split(',').map((e) => e.trim()).toList()
              : [],
          sentences: sentenceCtrl.text.isNotEmpty
              ? sentenceCtrl.text.split('|').map((e) => e.trim()).toList()
              : [],
        );
       controller.updateWord(index, updated);
    print(index);
       Navigator.pop(context);
      }else{
        Get.snackbar("Failed", "Word or Meaning cann't be empty");
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Edit Word")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              controller: wordCtrl,
              hintText: 'Word',
            ),
            CustomTextField(
              controller: meaningCtrl,
              hintText: 'Meaning',
            ),
            CustomTextField(
                hintText: 'Synonyms (comma separated)',
                controller: synonymCtrl),
            CustomTextField(
                controller: antonymCtrl,
                hintText: 'Antonyms (comma separated)'),
            CustomTextField(
                maxLines: 3,
                controller: sentenceCtrl,
                hintText: 'Sentences (separate by |)'),
            SizedBox(height: 16),
            ElevatedButton(onPressed: update, child: Text("Update")),
          ],
        ),
      ),
    );
  }
}
