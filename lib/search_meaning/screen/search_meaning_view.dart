import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vocab_learning/add_word.dart';
import 'package:vocab_learning/widget/custome_text_filed.dart';
import 'package:vocab_learning/search_meaning/controller/search_meaning_controller.dart';
import 'package:vocab_learning/search_meaning/model/onlinewordclass.dart';

class DictionaryScreen extends StatefulWidget {
  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  Future<OnlineWord>? futureWord;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Meaning'),
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.blue,
        onPressed: () {
          Get.to(AddWordPage());
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            CustomTextField(controller: _controller, hintText: "Enter Word "),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  futureWord = fetchWord(_controller.text);
                });
              },
              child: const Text(
                'Search in Internet',
                style: TextStyle(fontFamily: 'Cera Pro', color: Colors.black),
              ),
            ),
            Expanded(
              child: Center(
                child: FutureBuilder<OnlineWord>(
                  future: futureWord,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (!snapshot.hasData) {
                      return const Text("No data found");
                    } else {
                      final wordData = snapshot.data!;
                      return ListView(
                        children: <Widget>[
                          Text(
                            wordData.word,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          ...wordData.meanings.map((meaning) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    meaning.partOfSpeech,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ...meaning.definitions
                                      .map((definition) => ListTile(
                                            title: Text(definition.definition),
                                            subtitle: definition.example != null
                                                ? Text(
                                                    'Example: ${definition.example}')
                                                : null,
                                          )),
                                ],
                              )),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
