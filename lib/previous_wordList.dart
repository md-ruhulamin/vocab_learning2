import 'dart:convert';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:vocab_learning/audio/audio_view.dart';
import 'package:vocab_learning/controller/word_controller.dart';
import 'package:vocab_learning/widget/add_to_dictionary_btn.dart';
import 'package:vocab_learning/widget/custom_snakebar.dart';
import 'package:vocab_learning/widget/custom_text.dart';
import 'package:vocab_learning/wordModel.dart';
import 'package:vocab_learning/word_card.dart';

class PreviousWordListScreen extends StatefulWidget {
  @override
  _PreviousWordListScreenState createState() => _PreviousWordListScreenState();
}

class _PreviousWordListScreenState extends State<PreviousWordListScreen> {
  List<Word> words = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWords();
  }

  Future<void> fetchWords() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/md-ruhulamin/vocab_learning2/refs/heads/master/lib/data/wordlist.json'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        words = data.map((e) => Word.fromJson(e)).toList();
        words.sort(
            (a, b) => a.word.toLowerCase().compareTo(b.word.toLowerCase()));
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load word list');
    }
  }

  final WordController wordController = Get.find<WordController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Word List")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: words.length,
              itemBuilder: (context, index) {
                Word word = words[index];
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        print("Navigate Word List: ${words.length}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PrevWordFlashCard(
                                type: 4, words: words, realIndex: index),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
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
                                SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    addWord(word);
                                  },
                                  child: Icon(
                                    Icons.bookmark_add_outlined,
                                    size: 25,
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
            ),
    );
  }

  void addWord(Word addingWord) {
    try {
      final word = Word(
        isIdiom: false, // Assuming isIdiom is false for this case
        isBookmarked: true,
        id: DateTime.now()
            .millisecondsSinceEpoch, // Unique ID based on timestamp
        word: addingWord.word.trim(),
        meaning: addingWord.meaning.trim(),
        synonyms: addingWord.synonyms.isNotEmpty
            ? addingWord.synonyms.map((e) => e.trim()).toList()
            : [],
        antonyms: addingWord.antonyms.isNotEmpty
            ? addingWord.antonyms.map((e) => e.trim()).toList()
            : [],
        sentences: addingWord.sentences.isNotEmpty
            ? addingWord.synonyms.map((e) => e.trim()).toList()
            : [],
      );

      wordController.addWord(word);
    } catch (e) {
      showCustomSnackBar(
        Get.context!,
        "Invalid input!",
        backgroundColor: Colors.red.shade200,
      );
    }
  }
}

class PrevWordFlashCard extends StatefulWidget {
  final List<Word> words;
  int type; // Default type is 1 for word list
  int realIndex; // Placeholder for real index, adjust as needed
  PrevWordFlashCard(
      {super.key,
      required this.realIndex,
      required this.type,
      required this.words});

  @override
  State<PrevWordFlashCard> createState() => _PrevWordFlashCardState();
}

class _PrevWordFlashCardState extends State<PrevWordFlashCard> {
  bool showFlipCard = true;
  bool showDetails = true;

  @override
  void initState() {
    super.initState();
  }

  final WordController wordController = Get.find<WordController>();
  void addWord(Word addingWord) {
    try {
      final word = Word(
        isIdiom: false, // Assuming isIdiom is false for this case
        isBookmarked: true,
        id: DateTime.now()
            .millisecondsSinceEpoch, // Unique ID based on timestamp
        word: addingWord.word.trim(),
        meaning: addingWord.meaning.trim(),
        synonyms: addingWord.synonyms.isNotEmpty
            ? addingWord.synonyms.map((e) => e.trim()).toList()
            : [],
        antonyms: addingWord.antonyms.isNotEmpty
            ? addingWord.antonyms.map((e) => e.trim()).toList()
            : [],
        sentences: addingWord.sentences.isNotEmpty
            ? addingWord.synonyms.map((e) => e.trim()).toList()
            : [],
      );

      wordController.addWord(word);
    } catch (e) {
      showCustomSnackBar(
        Get.context!,
        "Invalid input!",
        backgroundColor: Colors.red.shade200,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.realIndex);
    Word word = widget.words[widget.realIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("(${widget.realIndex + 1}) ${word.word}"),
        actions: [],
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      addWord(word);
                                    },
                                    child: Icon(
                                      Icons.bookmark_add_outlined,
                                      size: 25,
                                      color: Colors.blue.shade800,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: SpeakTheWord(
                                        text: word.word, iconSize: 25),
                                  ),
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
                            const SizedBox(height: 55),
                          ],
                        ),
                      ),
                      back: Card(
                        elevation: 6,
                        color: const Color.fromARGB(255, 223, 241, 224),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                word.meaning,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Synonyms",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        height: 1,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        color: Colors.green.shade300,
                                      ),
                                      Text(
                                        word.synonyms.isNotEmpty
                                            ? word.synonyms.join('\n')
                                            : "No Synonyms",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 1,
                                    height: MediaQuery.of(context).size.height *
                                        0.10,
                                    color: Colors.green.shade300,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Antonyms",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        height: 1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        color: Colors.green.shade300,
                                      ),
                                      Text(
                                        word.antonyms.isNotEmpty
                                            ? word.antonyms.join('\n ')
                                            : "No Antonyms",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
                    if (widget.realIndex < widget.words.length - 1) {
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
        Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        ...items
            .map((e) => Text(
                  "- $e",
                  style: TextStyle(fontSize: 15),
                ))
            .toList(),
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
