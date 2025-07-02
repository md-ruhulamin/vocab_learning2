import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:vocab_learning/answer.dart';
import 'package:vocab_learning/controller.dart';
import 'package:vocab_learning/quiz_model.dart';
import 'package:vocab_learning/quiz_result.dart';
import 'package:vocab_learning/wordModel.dart';

class QuizPage extends StatefulWidget {
  final List<Word> userWords;

  const QuizPage({required this.userWords, Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizePageState();
}

class _QuizePageState extends State<QuizPage> {
  final List<Word> wordList = [];
  final List<QuizQuestion> questions = [];

  final Map<int, String> userAnswers = {};

  int currentIndex = 0;
  int selectedIndex = 1; // No option selected initially
  bool showResult = false;

  @override
  void initState() {
    super.initState();
    print("Initializing Quiz Page");
    wordList.addAll(widget.userWords);
   

    print("User words: ${widget.userWords.length}");
    generateQuestions();
    print("Generated ${questions.length} questions");

  }

  void fetchwords() {
    final WordController controller = Get.find<WordController>();
    final List<Word> userWords = controller.words;
    print("User words: ${userWords.length}");
    if (userWords.isEmpty) {
      print("No words available to quiz");
      return;
    }
    wordList.addAll(userWords);
  }

  void generateQuestions() {
    if (wordList.isEmpty) {
      print("No words available to generate questions");

      return;
    }
    // No words to generate questions
    final random = Random();

    for (var word in wordList) {
      // Skip if no data at all
      if ((word.synonyms.isEmpty && word.antonyms.isEmpty) ||
          word.meaning.trim().isEmpty) continue;

      // Randomly decide question type: 0 = meaning, 1 = synonym, 2 = antonym
      int questionType = random.nextInt(3);

      if (questionType == 0 && word.meaning.isNotEmpty) {
        // MEANING QUESTION
        String correct = word.meaning;
        Set<String> options = {correct};

        // Add 3 incorrect meanings from other words
        while (options.length < 4) {
          final other = wordList[random.nextInt(wordList.length)];
          if (other.meaning.isEmpty || other.word == word.word) continue;
          options.add(other.meaning);
        }

        questions.add(QuizQuestion(
          question: 'What is the meaning of "${word.word}"?',
          options: options.toList()..shuffle(),
          correctAnswer: correct,
          isSynonym: false,
          isMeaning: true, // <-- you may need to add this in your model
        ));
      } else if (questionType == 1 && word.synonyms.isNotEmpty) {
        // SYNONYM QUESTION
        String correct = word.synonyms[random.nextInt(word.synonyms.length)];
        Set<String> options = {correct};

        while (options.length < 4) {
          final other = wordList[random.nextInt(wordList.length)];
          if (other.synonyms.isEmpty || other.word == word.word) continue;
          final candidate =
              other.synonyms[random.nextInt(other.synonyms.length)];
          options.add(candidate);
        }

        questions.add(QuizQuestion(
          question: 'Which is a synonym of "${word.word}"?',
          options: options.toList()..shuffle(),
          correctAnswer: correct,
          isSynonym: true,
          isMeaning: false,
        ));
      } else if (word.antonyms.isNotEmpty) {
        // ANTONYM QUESTION
        String correct = word.antonyms[random.nextInt(word.antonyms.length)];
        Set<String> options = {correct};

        while (options.length < 4) {
          final other = wordList[random.nextInt(wordList.length)];
          if (other.antonyms.isEmpty || other.word == word.word) continue;
          final candidate =
              other.antonyms[random.nextInt(other.antonyms.length)];
          options.add(candidate);
        }

        questions.add(QuizQuestion(
          question: 'Which is an antonym of "${word.word}"?',
          options: options.toList()..shuffle(),
          correctAnswer: correct,
          isSynonym: false,
          isMeaning: false,
        ));
      }
    }
  }

  void submitAnswer(String answer) {
    setState(() {
      userAnswers[currentIndex] = answer;
      if (currentIndex < questions.length - 1) {
        currentIndex++;
      } else {
        showResult = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showResult) {
      return QuizResultPage(
        quizList: questions,
        userAnswers: userAnswers,
      );
      // int correct = 0;
      // for (int i = 0; i < questions.length; i++) {
      //   if (questions[i].correctAnswer == userAnswers[i]) correct++;
      // }
      // if (questions.isEmpty) {
      //   return Scaffold(
      //     appBar: AppBar(title: const Text("Quiz")),
      //     body: const Center(
      //       child: Text("No questions available. Please check your word list."),
      //     ),
      //   );
      // }
      // return Scaffold(
      //   appBar: AppBar(
      //     title: const Text("Quiz Report"),
      //     actions: [
      //       ElevatedButton(
      //           onPressed: () {
      //             Get.to(AnswerSheetScreen(
      //               quizList: questions,
      //               userAnswers: userAnswers,
      //             ));
      //           },
      //           child: Text("Detailed AnswerSheet"))          ],
      //   ),
      //   body: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: ListView(
      //       children: [
      //         Text("Total Questions: ${questions.length}"),
      //         Text("Correct: $correct"),
      //         Text("Wrong: ${questions.length - correct}"),
      //         const SizedBox(height: 20),
      //         const Text("Details:",
      //             style: TextStyle(fontWeight: FontWeight.bold)),
      //         ...List.generate(questions.length, (i) {
      //           final q = questions[i];
      //           final user = userAnswers[i] ?? 'Not answered';
      //           return ListTile(
      //             title: Text(q.question),
      //             subtitle:
      //                 Text("Your Answer: $user\nCorrect: ${q.correctAnswer}"),
      //             trailing: Icon(
      //               user == q.correctAnswer ? Icons.check : Icons.close,
      //               color: user == q.correctAnswer ? Colors.green : Colors.red,
      //             ),
      //           );
      //         })
      //       ],
      //     ),
      //   ),
      // );
    }

    final q = questions[currentIndex];
    return Scaffold(
      backgroundColor: const Color(0xFF10162E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Performance Analysis Quiz",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: "Question ",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  children: [
                    TextSpan(
                      text: "${currentIndex + 1}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    TextSpan(
                        text: "/${questions.length}",
                        style: TextStyle(color: Colors.white38)),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Progress Dotted Line (fake)
              Row(
                children: List.generate(
                  20,
                  (index) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      height: 4,
                      decoration: BoxDecoration(
                        color: index < 6 ? Colors.purple : Colors.grey[700],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Text(
                q.question,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 24),

              // Options
              Column(
                children: List.generate(
                  q.options.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedIndex == index
                              ? Colors.cyanAccent
                              : Colors.white30,
                          width: selectedIndex == index ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        color: selectedIndex == index
                            ? Colors.cyan.withOpacity(0.2)
                            : Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              q.options[index],
                              style: TextStyle(
                                color: selectedIndex == index
                                    ? Colors.cyan
                                    : Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          if (selectedIndex == index)
                            const Icon(Icons.check_circle, color: Colors.cyan),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),

              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      
                      foregroundColor: Colors.white54,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 14),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white24),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Quit Quiz",
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (currentIndex < questions.length - 1 &&
                          selectedIndex == -1) {
                        // Last question and no option selected
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select an answer"),
                          ),
                        );
                        return;
                      }
                      if (currentIndex == questions.length - 1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Quiz completed!"),
                          ),
                        );
                        setState(() {
                          showResult = true; // Show results after last question
                        });
                      }
                      setState(() {
                        submitAnswer(q.options[selectedIndex]);
                        selectedIndex = -1; // Reset selection for next question
                      });
                    },
                    child: const Text("Next",
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
