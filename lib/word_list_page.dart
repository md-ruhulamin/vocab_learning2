import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocab_learning/add_word.dart';
import 'package:vocab_learning/audio/audio_view.dart';
import 'package:vocab_learning/book_mark.dart';
import 'package:vocab_learning/controller.dart';
import 'package:vocab_learning/custom_text.dart';
import 'package:vocab_learning/quiz_page.dart';
import 'package:vocab_learning/wordModel.dart';
import 'package:vocab_learning/word_card.dart';
import 'package:vocab_learning/word_details.dart';

class WordListPage extends StatefulWidget {
  int type;
  WordListPage({super.key, this.type = 1}); // Default type is 1 for word list
  @override
  _WordListPageState createState() => _WordListPageState();
}

class _WordListPageState extends State<WordListPage> {
  final controller = Get.put(WordController());
  String searchQuery = "";
 @override
  void initState() {
    if(widget.type == 2) {
      controller.loadWords(); // Load words when the widget is initialized
    } else if(widget.type == 2) {
      controller.loadBookmarkedWords(); // Load bookmarked words if type is not 1
    }
    else if(widget.type == 3) {
      controller.loadIdioms(); // Load synonym words if type is 3
    }
    else{
       controller.loadWords(); // Load words when the widget is initialized
    }
  
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vocabulary List'),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Ensure userWords is not empty to prevent stuck behavior
              if (controller.words.length < 5) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Atleast five words needed for quiz")),
                );

                return;
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                      
                       QuizPage(userWords: controller.words.value),
                  ),
                );
              }
            },
            child: Text("Start Quiz"),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(hintText: "Search word..."),
              onChanged: (value) =>
                  setState(() => searchQuery = value.toLowerCase()),
            ),
          ),
          Expanded(
            child: Obx(() {
              final filtered = controller.words
                  .where((w) => w.word.toLowerCase().contains(searchQuery))
                  .toList();
              return ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (_, index) {
                  final word = filtered[index];
                  final realIndex = controller.words.indexOf(word);
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  WordDetailPage(word: word, index: realIndex),
                            ),
                          );
                        },
                        onLongPress: () {
                          print("Deleting word at index $realIndex");
                          controller.deleteWord(realIndex);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Word deleted")),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius: 5,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CustomText(
                                    text: "${index + 1}.${word.word}",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Spacer(),
                                  SpeakTheWord(text: word.word),
                                  SizedBox(width: 10),
                                  BookMarkWIdget(
                                      onTap: () {
                                        controller.toggleBookmark(realIndex);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(word.isBookmarked
                                                ? "Bookmarked"
                                                : "Bookmark removed"),
                                          ),
                                        );
                                      },
                                      realIndex: realIndex,
                                      word: word),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => WordCard(
                                              word: word, realIndex: realIndex),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: Colors.blue.shade800,
                                    ),
                                  ),
                                ],
                              ),
                              Text("-${word.meaning}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey.shade700)),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                    ],
                  );
                },
              );
            }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.amber,
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddWordPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
