import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocab_learning/controller/word_controller.dart';
import 'package:vocab_learning/widget/custom_button.dart';
import 'package:vocab_learning/widget/custom_snakebar.dart';
import 'package:vocab_learning/widget/custome_text_filed.dart';
import 'package:vocab_learning/wordModel.dart';

class AddWordPage extends StatefulWidget {
  @override
  State<AddWordPage> createState() => _AddWordPageState();
}

class _AddWordPageState extends State<AddWordPage> {
  final WordController controller = Get.put(WordController());

  final wordController = TextEditingController();

  final meaningController = TextEditingController();

  final synonymController = TextEditingController();

  final antonymController = TextEditingController();

  final sentenceController = TextEditingController();

  bool isIdiom = false; 
 // Local variable
  void addWord() {
    if (wordController.text.isNotEmpty && meaningController.text.isNotEmpty) {
      final word = Word(
        isIdiom:isIdiom, 
        isBookmarked: false,
        id: DateTime.now()
            .millisecondsSinceEpoch, // Unique ID based on timestamp
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
      sentenceController.clear(); setState(() {
        isIdiom = false; // Reset after adding
      });
    } else {
      showCustomSnackBar(
        Get.context!,
        "Invalid input!",
        backgroundColor: Colors.red.shade200,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
    //  resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Add Word')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CustomTextField(
                controller: wordController,
                hintText: 'Word',
                labelText: 'Enter the word',
              ),
              CustomTextField(
                controller: meaningController,
                hintText: 'Meaning',
                labelText: 'Enter the meaning',
              ),
              CustomTextField(
                  hintText: 'Synonyms comma(,) separated',
                  controller: synonymController,
                  labelText: 'Ex: Syn1, Syn2, Syn3,......'),
              CustomTextField(
                  labelText: 'Ex: Ant1, Ant2, Ant3,......',
                  controller: antonymController,
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
                  labelText: ' Ex: Sentence1 | Sentence2 | Sentence3...',
                  controller: sentenceController,
                  hintText: 'Sentences (separate by |)'),
              SizedBox(height: 10),
              CustomButton(
                onPressed: addWord,
                text: 'Add Word',
                width: 340,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
