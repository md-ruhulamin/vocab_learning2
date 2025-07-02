import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocab_learning/search_meaning/screen/search_meaning_view.dart';
import 'package:vocab_learning/word_list_page.dart';

class QuizHomePage extends StatelessWidget {
  const QuizHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Row
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/150?img=1'), // Placeholder image
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Jonathan Smith",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FlipCard(
                front: Container(
                  height: 180,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Play & Win",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "De Finibus Bonorum et Malorum for use",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                back: Container(
                  height: 180,
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
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
                        "  Word of the Day Quiz",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              )
              // Banner
              ,
              const SizedBox(height: 10),

              // Top Quiz Categories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Top Quiz Categories",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("View All"),
                  ),
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
                      label: "Word List",
                      onTap: () {
                        Get.to(WordListPage(type: 1));
                      }),
                  CategoryTile(
                      icon: Icons.bookmark,
                      label: "BookMark",
                      onTap: () {
                        Get.to(WordListPage(type: 2));
                      }),
                  CategoryTile(
                      icon: Icons.edit_document,
                      label: "Idioms",
                      onTap: () {
                        Get.to(WordListPage(type: 3));
                      }),
                  CategoryTile(
                    icon: Icons.brush,
                    label: "Art & Craft",
                    onTap: () {},
                  ),
                  CategoryTile(
                    icon: Icons.broadcast_on_personal_outlined,
                    label: "Search Online",
                    onTap: () {
                      Get.to(DictionaryScreen());
                    },
                  ),
                  CategoryTile(
                    icon: Icons.language,
                    label: "Language",
                    onTap: () {},
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
