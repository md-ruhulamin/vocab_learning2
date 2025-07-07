import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocab_learning/answer.dart';
import 'package:vocab_learning/controller/word_controller.dart';
import 'package:vocab_learning/homepage.dart';
import 'package:vocab_learning/quiz/quiz_model.dart';

import 'quiz_page.dart' as quiz_page;

class QuizResultPage extends StatelessWidget {
  QuizResultPage(
      {super.key, required this.quizList, required this.userAnswers});

  Set<QuizQuestion> quizList;
  final Map<int, String> userAnswers;
  @override
  Widget build(BuildContext context) {
    int correct = 0;
    for (int i = 0; i < quizList.length; i++) {
      if (quizList.elementAt(i).correctAnswer == userAnswers[i]) correct++;
    }
    int totalQuestions = quizList.length;
    int incorrect = totalQuestions - correct;

    return Scaffold(
      backgroundColor: const Color(0xFF10162E),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Quiz Result",
                  style: TextStyle(color: Colors.white70, fontSize: 30),
                ),
                const SizedBox(height: 10),

                // Trophy with Avatar
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/trophy.png', // Replace with your trophy asset
                      height: 170,
                    ),
                    // const CircleAvatar(
                    //   radius: 30,
                    //   backgroundImage: AssetImage('assets/avatar.jpg'), // Replace with your image
                    // ),
                    Positioned(
                      bottom: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "WINNER",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Congrats text
                const Text(
                  "Congratulations!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "You have completed the quiz successfully.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white60, fontSize: 14),
                ),
                Text(
                  "Correct answers: $correct | Incorrect answers: $incorrect",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white60, fontSize: 14),
                ),
                const SizedBox(height: 20),

                // Score
                const Text(
                  "YOUR SCORE",
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 6),
                Text(
                  "${(correct - incorrect * .25)} / ${quizList.length}",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.cyan,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Earned Coins
                const Text(
                  "EARNED COINS",
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.monetization_on, color: Colors.amber, size: 24),
                    SizedBox(width: 6),
                    Text(
                      "${correct * 10} Coins",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white24),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Get.offAll(QuizHomePage());
                        },
                        icon: const Icon(Icons.home),
                        label: const Text("Back to Home"),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Get.to(() => AnswerSheetScreen(
                                quizList: quizList,
                                userAnswers: userAnswers,
                              )); // Navigate to Quiz Page
                        },
                        child: const Text("AnswerSheet"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Close Button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white12,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
