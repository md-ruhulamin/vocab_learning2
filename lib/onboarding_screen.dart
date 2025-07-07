import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vocab_learning/controller/user_controller.dart';
import 'package:vocab_learning/homepage.dart';
import 'package:vocab_learning/quiz/quiz_result.dart';
import 'package:vocab_learning/widget/custom_button.dart';
import 'package:vocab_learning/widget/custom_snakebar.dart';
import 'package:vocab_learning/widget/custome_text_filed.dart';
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

  final TextEditingController nameController = TextEditingController();
  final UserController userController = Get.put(UserController());

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
            const Text("Expand Your Lexicon\nDiscover, Learn and Remember.",
                style: TextStyle(fontSize: 23)),

            //     SizedBox(height: 10,),
            Image.asset(
              "assets/images/icon.png",
              height: 300,
            ),
            CustomTextField(
              controller: nameController,
              hintText: "",
              labelText: "Enter Your Name",
            ),

            CustomButton(
              width: 340,
              text: "Let's Practice",
              onPressed: () async{
                if (nameController.text.isEmpty) {
                  showCustomSnackBar(
                    context,
                    "Please enter your name",
                  );
                  return;
                }
             await userController.saveUser(nameController.text);
                Get.off(QuizHomePage());
              },
            )
          ],
        ),
      )),
    );
  }
}
