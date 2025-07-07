import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocab_learning/controller/word_controller.dart';
import 'package:vocab_learning/controller/user_controller.dart';
import 'package:vocab_learning/default_words_list.dart';
import 'package:vocab_learning/pdf_view_page.dart';
import 'package:vocab_learning/quiz/quiz_info.dart';
import 'package:vocab_learning/quiz/quiz_page.dart';
import 'package:vocab_learning/scramble_game.dart';
import 'package:vocab_learning/search_meaning/screen/search_meaning_view.dart';
import 'package:vocab_learning/syno_anto_list_page.dart';
import 'package:vocab_learning/widget/greeting_text.dart';
import 'package:vocab_learning/word_list_page.dart';

class QuizHomePage extends StatelessWidget {
  QuizHomePage({super.key});

  final controller = Get.put(WordController());

  @override
  Widget build(BuildContext context) {
      final userController = Get.find<UserController>();
    final name = userController.userName.value ?? "";

    return Scaffold(
      backgroundColor: Colors.grey[200],
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 0,
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.grey,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.category), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
      //   ],
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Row
              Row(
                children: [
                  const Icon(Icons.account_circle, size: 40),
                  const SizedBox(width: 12),
                   InkWell(
                    onTap: () {
                      userController.nameController.text = name;
                      // Show dialog to change name
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          title: const Text("Change Name"),
                          content: TextField(
                            controller: userController.nameController,
                            decoration: const InputDecoration(
                              hintText: "Enter your name",
                            ),
                          ),
                          actions: [
                          
                            OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                              OutlinedButton(
                              onPressed: () {
                                userController.updateUser( userController.nameController.text);
                                Navigator.pop(context);
                              },
                              child: const Text("Save"),
                            ),
                          ],
                        );
                      });
                    },
                     child: Text(
                      "$name",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                       ),
                   ),
                ],
              ),
              const SizedBox(height: 20),
              FlipCard(
                front: Container(
                  height: 200,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/4359/4359871.png'),
                      alignment: Alignment.centerRight,
                      fit: BoxFit.fitHeight,
                      opacity: 0.1,
                    ),
                  ),
                  child: const Column(
              
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GreetingText(),
                      // Text(
                      //   "Play & Win",
                      //   style: TextStyle(
                      //       fontSize: 22,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.white),
                      // ),
                      // SizedBox(height: 5),
                      // Text(
                      //   "Enrich your Vocabulary & Grow your Skills",
                      //   style: TextStyle(color: Colors.white70),
                      // ),
                    ],
                  ),
                ),
                back: Container(
                  height: 200,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700,
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/4359/4359871.png'),
                      alignment: Alignment.centerRight,
                      fit: BoxFit.fitHeight,
                      opacity: 0.1,
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Text(
                        "Learn & Earn",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        " Play quizzes to earn coins and rewards",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              )
              // Banner
              ,
              const SizedBox(height: 15),

              // Top Quiz Categories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Top Quiz Categories",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // TextButton(
                  //   onPressed: () {},
                  //   child: const Text("View All"),
                  // ),
                ],
              ),
              const SizedBox(height: 12),
              //  1=WOrd
              //  2=bookmark
              //  3=idioms
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  CategoryTile(
                      icon: Icons.menu_book_sharp,
                      label: "My Word List",
                      onTap: () {
                        Get.to(WordListPage(type: 1));
                      }),
                  CategoryTile(
                      icon: Icons.bookmark,
                      label: "Bookmark",
                      onTap: () {
                        Get.to(WordListPage(type: 2));
                      }),
                  CategoryTile(
                      icon: Icons.edit_document,
                      label: "Idioms & Phrases",
                      onTap: () {
                        Get.to(WordListPage(type: 3));
                      }),   CategoryTile(
                    icon: Icons.sync_alt_rounded,
                    label: "Synonym & Antonym",
                    onTap: () {
                      Get.to(SynAntonymListPage(type: 5,));
                    },
                  ),  CategoryTile(
                    icon: Icons.text_snippet,
                    label: "Sample Words",
                    onTap: () {
                      Get.to(DefaultWordsList(type: 0));
                    },
                  ),
                  CategoryTile(
                    icon: Icons.smart_toy_rounded,
                    label: "Learn via Stories",
                    onTap: () {
                      Get.to(PDFScreen());
                    },
                  ),
                  CategoryTile(
                    icon: Icons.quiz,
                    label: "Quiz",
                    onTap: () {
                      Get.to(QuizPageInfo());
                    },
                  ),
                  CategoryTile(
                    icon: Icons.language,
                    label: "Search Online",
                    onTap: () {
                      Get.to(DictionaryScreen());
                    },
                  ),
                
                 
                    CategoryTile(
                    icon: Icons.games,
                    label: "Learn via Games",
                    onTap: () {
                      Get.to(WordScrambleGame());
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const CategoryTile(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Colors.blue),
            const SizedBox(height: 8),
            Text(label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
