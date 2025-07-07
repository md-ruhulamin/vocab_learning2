import 'dart:math';

import 'package:flutter/material.dart';

class WordScrambleGame extends StatefulWidget {
  @override
  _WordScrambleGameState createState() => _WordScrambleGameState();
}

class _WordScrambleGameState extends State<WordScrambleGame> {
  List<String> wordList = [
    // Common
    'apple', 'banana', 'orange', 'grape', 'mango', 'chair', 'table', 'book',
    'pen', 'phone',

    // Emotions
    'happy', 'angry', 'excited', 'nervous', 'brave', 'confused', 'joyful',
    'fearless',

    // Verbs
    'run', 'jump', 'write', 'read', 'swim', 'dance', 'sleep', 'think', 'listen',
    'speak',

    // Academic
    'biology', 'physics', 'history', 'algebra', 'grammar', 'chemistry',
    'literature', 'university',

    // Vocabulary level-up
    'abandon', 'benevolent', 'courageous', 'diligent', 'eloquent', 'fascinate',
    'gracious', 'humble', 'ingenious', 'jubilant',
    'keen', 'lucid', 'meticulous', 'notorious', 'obstinate', 'pragmatic',
    'quaint', 'resilient', 'scrutinize', 'tenacious',

    // Synonym-Antonym Friendly
    'hot', 'cold', 'soft', 'hard', 'bright', 'dark', 'big', 'small', 'fast',
    'slow',

    // Idioms/Phrases compatible
    'break', 'ice', 'spill', 'beans', 'hit', 'sack', 'cost', 'arm', 'leg',
    'bite',

    // From your app theme
    'vocabulary', 'synonym', 'antonym', 'flashcard', 'quiz', 'bookmark',
    'search', 'story', 'phrase', 'learn',

    // Animals
    'tiger', 'lion', 'zebra', 'panda', 'giraffe', 'monkey', 'rabbit', 'wolf',
    'elephant', 'fox',

    // Advanced Vocabulary
    'ephemeral', 'oblivion', 'reverie', 'solitude', 'eloquence', 'melancholy',
    'serenity', 'nostalgia', 'ineffable', 'sonder',
  ];

  late String originalWord;
  late List<String> shuffledLetters;
  String userAnswer = '';
  int score = 0;
  bool isHide = true;
  @override
  void initState() {
    super.initState();
    loadNewWord();
  }

  void loadNewWord() {
    final random = Random();
    originalWord = wordList[random.nextInt(wordList.length)];
    shuffledLetters = originalWord.split('')..shuffle();

    // Make sure it's not the same as the original
    while (shuffledLetters.join() == originalWord) {
      shuffledLetters.shuffle();
    }

    userAnswer = '';
    setState(() {});
  }

  void checkAnswer() {
    if (userAnswer == originalWord) {
      setState(() {
        score++;
      });

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Correct! 🎉'),
          content: Text('Score: $score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                loadNewWord();
              },
              child: Text('Next'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wrong! Try again')),
      );
    }
  }

  void clearAnswer() {
    setState(() {
      userAnswer = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Scramble'),
        actions: [
          
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Center(child: Text("Score: $score", style: TextStyle(fontSize: 23))),
          ),
              SizedBox(height: 20),
              Text('Arrange the letters to form a word:',
                  style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),

              Wrap(
                spacing: 10,
                children: shuffledLetters.map((letter) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        userAnswer += letter;
                      });
                    },
                    child: Text(letter.toUpperCase(),
                        style: TextStyle(fontSize: 24)),
                  );
                }).toList(),
              ),
              SizedBox(height: 30),
              Text('Your answer:', style: TextStyle(fontSize: 16)),
              Text(userAnswer,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: checkAnswer, child: Text('Submit')),
                  SizedBox(width: 20),
                  OutlinedButton(onPressed: clearAnswer, child: Text('Clear')),
                  SizedBox(width: 20),
                  OutlinedButton(
                      onPressed: () {
                        loadNewWord();
                      },
                      child: Text("Skip")),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        setState(() {
                          isHide = !isHide;
                        });
                      },
                      child:isHide? Text('Show Answer') : Text('Hide Answer')),
                  Text('= : $originalWord',
                      style: TextStyle(fontSize: 16, color:   isHide? Colors.transparent : Colors.black)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
