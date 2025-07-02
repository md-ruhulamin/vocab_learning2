import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vocab_learning/audio/audio_view.dart';
import 'package:vocab_learning/book_mark.dart';
import 'package:vocab_learning/controller.dart';
import 'package:vocab_learning/edit_word.dart';
import 'package:vocab_learning/wordModel.dart';
import 'package:vocab_learning/word_list_page.dart';

class WordCard extends StatefulWidget {
  final Word word;
  final int realIndex; // Placeholder for real index, adjust as needed
  WordCard({super.key, required this.realIndex, required this.word});

  @override
  State<WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  final WordController controller = Get.put(WordController());
  List<Word> words = [];
  late Word word;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the word from the controller using the realIndex
    word = controller.words[widget.realIndex];
  }

  // Load words when the widget is initialized
  @override
  void initState() {
    controller.loadWords(); // Fetch words when the widget is initialized
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.realIndex);
    return Scaffold(
      appBar: AppBar(
        title: Text(word.word),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditWordPage(
                      word: widget.word,
                      index: widget.realIndex), // Assuming index is 0 for simplicity
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FlipCard(
                  direction: FlipDirection.HORIZONTAL, // or VERTICAL
                  front: Card(
                    elevation: 6,
                    color: Colors.blue.shade100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.toggleBookmark(widget.realIndex);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(controller
                                              .words[widget.realIndex]
                                              .isBookmarked
                                          ? "Bookmarked"
                                          : "Bookmark removed"),
                                    ),
                                  );
                                },
                                child: Obx(
                                  ()=> Icon(
                                    controller
                                            .words[widget.realIndex].isBookmarked
                                        ? Icons.bookmark
                                        : Icons.bookmark_add_outlined,
                                    size: 25,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                              ),
                              SpeakTheWord(text: widget.word.word),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Text(
                            widget.word.word,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  back: Card(
                    elevation: 6,
                    color: Colors.green.shade100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          widget.word.meaning,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 420,
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: [
                  if (widget.word.synonyms.isNotEmpty)
                    Text("Synonyms:\n ${widget.word.synonyms.join(', ')}",
                        style: TextStyle(fontSize: 16)),
                  if (widget.word.antonyms.isNotEmpty)
                    Text("Antonyms:\n ${widget.word.antonyms.join(', ')}",
                        style: TextStyle(fontSize: 16)),
                  if (widget.word.sentences.isNotEmpty)
                    ...widget.word.sentences
                        .map((sentence) => Text("Example: $sentence",
                            style: TextStyle(fontSize: 16)))
                        .toList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
