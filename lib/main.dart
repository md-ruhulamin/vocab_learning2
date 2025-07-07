import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vocab_learning/controller/user_controller.dart';
import 'package:vocab_learning/homepage.dart';
import 'package:vocab_learning/onboarding_screen.dart';
import 'package:vocab_learning/word_list_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    final userController = Get.put(UserController());
  await userController.loadUser();
  runApp( MyApp(userController: userController,));
}

class MyApp extends StatelessWidget {
    final UserController userController;

   MyApp({super.key, required this.userController});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        home: Obx(() {
        return userController.userName.value == null
            ? Onboarding()
            :  QuizHomePage();
      }),
    );
  }
}
