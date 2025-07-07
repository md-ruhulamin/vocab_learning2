import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocab_learning/controller.dart';
import 'package:vocab_learning/data/sample_words.dart';
import 'package:vocab_learning/quiz/quiz_page.dart';
import 'package:vocab_learning/widget/custom_button.dart';
import 'package:vocab_learning/widget/custom_snakebar.dart';
import 'package:vocab_learning/widget/custom_text.dart';
import 'package:vocab_learning/widget/custome_text_filed.dart';
import 'package:vocab_learning/wordModel.dart';

class QuizPageInfo extends StatefulWidget {
  const QuizPageInfo({super.key});
  @override
  State<QuizPageInfo> createState() => _QuizPageInfoState();
}

class _QuizPageInfoState extends State<QuizPageInfo> {
  final TextEditingController MCQNumberController =
      new TextEditingController(text: "10");
  late WordController wordController = Get.put(WordController());

  int _selectedValue = 1;
  @override
  void initState() {
    super.initState();
    wordController.loadWords();
  }

  List<Word> _wordlist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assess Your Skills"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: MCQNumberController,
                    hintText: "Number of MCQ (Greater than 5)",
                    keyboardType: TextInputType.number,
                    labelText: "Ex. 10,15,20 ",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: <Widget>[
                      RadioListTile<int>(
                        title: CustomText(
                          text: 'My Word List',
                          fontSize: 17,
                        ),
                        value: 1,
                        groupValue: _selectedValue,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                      ),
                      RadioListTile<int>(
                        title: CustomText(
                          text: 'Bookmarked Words',
                          fontSize: 17,
                        ),
                        value: 2,
                        groupValue: _selectedValue,
                        onChanged: (int? value) {
                          setState(() {
                            //   print(wordController.mywordList.length);
                            _selectedValue = value!;
                          });
                        },
                      ),
                      RadioListTile<int>(
                        title: CustomText(
                          text: 'Idiom and Phrases',
                          fontSize: 17,
                        ),
                        value: 3,
                        groupValue: _selectedValue,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedValue = value!;
                          });
                        },
                      ),
                      RadioListTile<int>(
                        title: CustomText(
                          text: 'Sample Words',
                          fontSize: 17,
                        ),
                        value: 4,
                        groupValue: _selectedValue,
                        onChanged: (int? value) {
                          setState(() {
                            //   print(idiomController.myIdiomList.length);
                            _selectedValue = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                      width: context.width * 0.8,
                      onPressed: () {
                        if (MCQNumberController.text.isNotEmpty && int.parse(MCQNumberController.text.toString()) >
                            5) {
                          if (_selectedValue == 1) {
                            _wordlist = wordController.words.value;
                          } else if (_selectedValue == 2) {
                            _wordlist = wordController.bookmarkedWords;
                          } else if (_selectedValue == 3) {
                            _wordlist = wordController.idioms;
                          } else if (_selectedValue == 4) {
                            _wordlist = sampleWords;
                          }
                          if (_wordlist.length <
                              int.parse(MCQNumberController.text.toString())) {
                            showCustomSnackBar(
                              context,
                              "Your selected words are less than the number of MCQ",
                            );
                          } else {
                            Get.to(
                              QuizPage(
                                  userWords: _wordlist,
                                  numberofMCQ: int.parse(
                                      MCQNumberController.text.toString())),
                            );
                          }
                        } else {
                          showCustomSnackBar(
                            context,
                            "Please enter a number greater than 5",
                          );
                        }
                      },
                      text: "Start Quiz"),
                  SizedBox(
                    height: 20,
                  ),
                  CustomText(
                    text:
                        'Mark for Each Question : 1 \nNegative Mark for Each : 0.25',
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
