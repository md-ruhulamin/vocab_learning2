
import 'package:flutter/material.dart';
import 'package:vocab_learning/edit_word.dart';
import 'package:vocab_learning/wordModel.dart';

class WordDetailPage extends StatelessWidget {
  final Word word;
  final int index;

  WordDetailPage({required this.word, required this.index});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(word.word),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => EditWordPage(word: word, index: index)),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Word: ${word.word}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("Meaning: ${word.meaning}"),
            SizedBox(height: 12),
            buildList("Synonyms", word.synonyms),
            buildList("Antonyms", word.antonyms),
            buildList("Sentences", word.sentences),
          ],
        ),
      ),
    );
  }
}
