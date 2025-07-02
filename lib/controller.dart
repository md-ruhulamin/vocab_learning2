


import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocab_learning/wordModel.dart';

class WordController extends GetxController {
  final words = <Word>[].obs;

  Future<void> loadWords() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('words') ?? [];
    words.value = data.map((e) => Word.decode(e)).toList();
  }
   Future<void> loadBookmarkedWords() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('words') ?? [];
    words.value = data.map((e) => Word.decode(e)).toList();
  }
   Future<void> loadIdioms() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('words') ?? [];
    words.value = data.map((e) => Word.decode(e)).toList();
  }

  Future<void> saveWords() async {
    final prefs = await SharedPreferences.getInstance();
    final data = words.map((e) => e.encode()).toList();
    await prefs.setStringList('words', data);
  }

  void toggleBookmark(int index) {
    final word = words[index];
    word.isBookmarked = !word.isBookmarked;
    words[index] = word;
    saveWords();
  }
  void addWord(Word word) {
    words.add(word);
    saveWords();
  }

  void updateWord(int index, Word updatedWord) {
    words[index] = updatedWord;
    saveWords();
  }

  void deleteWord(int index) {
    words.removeAt(index);
    saveWords();
  }
List<Word> get bookmarkedWords => words.where((w) => w.isBookmarked).toList();



  @override
  void onInit() {
  
    super.onInit();
  }
}