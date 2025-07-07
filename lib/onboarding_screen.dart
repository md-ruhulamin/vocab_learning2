import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocab_learning/homepage.dart';
import 'package:vocab_learning/quiz/quiz_result.dart';
import 'package:vocab_learning/widget/custom_button.dart';
import 'package:vocab_learning/word_list_page.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void initState() {
    super.initState();
    // Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

//           Unlock the World of Words.”
// “Expand Your Lexicon.”
// “Word by Word, We Grow.”\
          children: [
            const Text("Expand Your Lexicon Discover Learn and Remember.",
                style: TextStyle(fontSize: 23)),
            //     SizedBox(height: 10,),
            Image.asset(
              "assets/images/icon.png",
              height: 300,
            ),

            CustomButton(
              width: 340,
              text: "Let's Practice",
              onPressed: () {
                Get.off(QuizHomePage());
              },
            )
          ],
        ),
      )),
    );
  }
}
