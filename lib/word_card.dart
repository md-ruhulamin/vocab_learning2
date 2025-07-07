import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:vocab_learning/audio/audio_view.dart';
import 'package:vocab_learning/book_mark.dart';
import 'package:vocab_learning/controller.dart';
import 'package:vocab_learning/edit_word.dart';
import 'package:vocab_learning/widget/custom_snakebar.dart';
import 'package:vocab_learning/wordModel.dart';
import 'package:vocab_learning/word_list_page.dart';

class WordCard extends StatefulWidget {
  final List<Word> words;
  int realIndex; // Placeholder for real index, adjust as needed
  WordCard({super.key, required this.realIndex, required this.words});

  @override
  State<WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> {
  final WordController controller = Get.put(WordController());
  List<Word> words = [];
  late Word word;
  bool showFlipCard = true;
  bool showDetails = true;
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
    Word word = controller.words[widget.realIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("(${widget.realIndex + 1}) ${word.word}"),
        actions: [
          if (controller.type != 0)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditWordPage(
                      word: word,
                      index: widget.realIndex,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text("Hide FlipCard"),
                    Switch(
                      value: !showFlipCard,
                      onChanged: (value) {
                        setState(() {
                          showFlipCard = !value;
                          if (!showFlipCard && !showDetails) {
                            showDetails = true;
                          }
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Hide Details"),
                    Switch(
                      value: !showDetails,
                      onChanged: (value) {
                        setState(() {
                          showDetails = !value;
                          if (!showFlipCard && !showDetails) {
                            showFlipCard = true;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            if (showFlipCard)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                      front: Card(
                        elevation: 6,
                        color: Colors.blue.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.toggleBookmark(word);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            controller.words[widget.realIndex]
                                                    .isBookmarked
                                                ? "Bookmarked"
                                                : "Bookmark removed",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Obx(
                                      () => Icon(
                                        controller.words[widget.realIndex]
                                                .isBookmarked
                                            ? Icons.bookmark
                                            : Icons.bookmark_add_outlined,
                                        size: 25,
                                        color: Colors.blue.shade800,
                                      ),
                                    ),
                                  ),
                                  SpeakTheWord(text: word.word),
                                ],
                              ),
                            ),
                            Center(
                              child: Text(
                                word.word,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                      back: Card(
                        elevation: 6,
                        color: Colors.green.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              word.meaning,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (showDetails)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                  child: ListView(
                    children: [
                      Text(
                        "~${word.word}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Meaning: ${word.meaning}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                      buildList("Synonyms", word.synonyms),
                      buildList("Antonyms", word.antonyms),
                      buildList("Sentences", word.sentences),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavigationButton(
                  text: 'PREV',
                  color: Colors.orange,
                  icon: Icons.arrow_back,
                  isLeft: true,
                  onPressed: () {
                    if (widget.realIndex > 0) {
                      widget.realIndex--;
                      setState(() {});
                    } else {
                      showCustomSnackBar(
                        context,
                        "Start of List, No previous words to show",
                      );
                    }
                  },
                ),
                const SizedBox(width: 20),
                NavigationButton(
                  text: 'NEXT',
                  color: Colors.green,
                  icon: Icons.arrow_forward,
                  isLeft: false,
                  onPressed: () {
                    if (widget.realIndex < controller.words.length - 1) {
                      widget.realIndex++;
                      setState(() {});
                    } else {
                      showCustomSnackBar(
                        context,
                        "End of List, No more words to show",
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList(String title, List<String> items) {
    if (items.isEmpty) return SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        ...items.map((e) => Text("- $e")).toList(),
        SizedBox(height: 8),
      ],
    );
  }
}

class NavigationButton extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;
  final bool isLeft;
  final VoidCallback onPressed;

  const NavigationButton({
    super.key,
    required this.text,
    required this.color,
    required this.icon,
    required this.isLeft,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: isLeft
            ? [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 10),
                Text(
                  text,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ]
            : [
                Text(
                  text,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(icon, color: color),
                ),
              ],
      ),
    );
  }
}
