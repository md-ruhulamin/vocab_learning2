import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocab_learning/controller/word_controller.dart';
import 'package:vocab_learning/widget/custom_button.dart';
import 'package:vocab_learning/widget/custome_text_filed.dart';
import 'package:vocab_learning/wordModel.dart';

class EditWordPage extends StatelessWidget {
  final Word word;
  final int index;

  EditWordPage({super.key, required this.word, required this.index});

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
          isBookmarked: word.isBookmarked,
          isIdiom: word.isIdiom, // Assuming isIdiom is part of the
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
        controller.updateWord(updated);
        print(index);
        Navigator.pop(context);
      } else {
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
                 Row(
              children: [
                SizedBox(width: 10),
                Text('Is Idiom?', style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                Obx(() => Row(
                      children: [
                        Radio<bool>(
                          value: word.isIdiom? true : false,
                          groupValue: controller.isIdiom.value,
                          onChanged: (val) => controller.isIdiom.value = val!,
                        ),
                        Text('Yes'),
                        Radio<bool>(
                          value: word.isIdiom? false : true,
                          groupValue: controller.isIdiom.value,
                          onChanged: (val) => controller.isIdiom.value = val!,
                        ),
                        Text('No'),
                      ],
                    )),
              ],
            ),
            CustomTextField(
                maxLines: 3,
                controller: sentenceCtrl,
                hintText: 'Sentences (separate by |)'),
            SizedBox(height: 16),
            
            CustomButton(onPressed: update, text: 'Update Word', width: 340),
          ],
        ),
      ),
    );
  }
}
