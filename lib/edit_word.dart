import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocab_learning/controller/word_controller.dart';
import 'package:vocab_learning/widget/custom_button.dart';
import 'package:vocab_learning/widget/custome_text_filed.dart';
import 'package:vocab_learning/wordModel.dart';

class EditWordPage extends StatefulWidget {
  final Word word;
  final int index;

  EditWordPage({super.key, required this.word, required this.index});

  @override
  State<EditWordPage> createState() => _EditWordPageState();
}

class _EditWordPageState extends State<EditWordPage> {
  final controller = Get.find<WordController>();
  late TextEditingController wordCtrl;
  late TextEditingController meaningCtrl;
  late TextEditingController synonymCtrl;
  late TextEditingController antonymCtrl;
  late TextEditingController sentenceCtrl;

  late bool isIdiom;

  @override
  void initState() {
    super.initState();
    wordCtrl = TextEditingController(text: widget.word.word);
    meaningCtrl = TextEditingController(text: widget.word.meaning);
    synonymCtrl = TextEditingController(text: widget.word.synonyms.join(', '));
    antonymCtrl = TextEditingController(text: widget.word.antonyms.join(', '));
    sentenceCtrl = TextEditingController(text: widget.word.sentences.join('| '));
    isIdiom = widget.word.isIdiom;
  }

  void update() {
    if (meaningCtrl.text.isNotEmpty && wordCtrl.text.isNotEmpty) {
      final updated = Word(
        id: widget.word.id,
        word: wordCtrl.text,
        isBookmarked: widget.word.isBookmarked,
        isIdiom: isIdiom, // Use local variable
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
      Navigator.pop(context);
    } else {
      Get.snackbar("Failed", "Word or Meaning can't be empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Edit Word")),
      body: SingleChildScrollView(
        child: Padding(
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
                  Checkbox(
                    value: isIdiom,
                    onChanged: (val) {
                      setState(() {
                        isIdiom = true;
                      });
                    },
                  ),
                  Text('Yes'),
                  Checkbox(
                    value: !isIdiom,
                    onChanged: (val) {
                      setState(() {
                        isIdiom = false;
                      });
                    },
                  ),
                  Text('No'),
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
      ),
    );
  }
}