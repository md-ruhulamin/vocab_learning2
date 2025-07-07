import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocab_learning/data/sample_words.dart';
import 'package:vocab_learning/wordModel.dart';
import 'dart:convert';



class WordController extends GetxController {
  final RxList<Word> _allWords = <Word>[].obs;
  final RxList<Word> words = <Word>[].obs;
  final RxInt type = 1.obs; // 1: All, 2: Bookmarked, 3: Idioms
  RxBool isIdiom = true.obs;
  @override
  void onInit() {
    super.onInit();
    loadWords();
  }

  Future<void> loadWords() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('words') ?? [];

    _allWords.value = data.map((e) => Word.decode(e)).toList();
    _filterWords();
  }

  Future<void> saveWords() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _allWords.map((e) => e.encode()).toList();
    await prefs.setStringList('words', data);
    _filterWords(); // Update filtered list after saving
  }

  void _filterWords() {
    if (type.value == 1) {
      words.value = _allWords;
    } else if (type.value == 2) {
      words.value = _allWords.where((w) => w.isBookmarked).toList();
    } else if (type.value == 3) {
      words.value = _allWords.where((w) => w.isIdiom).toList();
    }else if (type.value == 0) {
      words.value =sampleWords;
    } else {
      words.value = [];
    }
  }

  void changeType(int newType) {
    type.value = newType;
    _filterWords();
  }

  void toggleBookmark(Word word) {
    final index = _allWords.indexWhere((w) => w.id == word.id);
    if (index != -1) {
      _allWords[index].isBookmarked = !_allWords[index].isBookmarked;
      saveWords();
    }
  }

  void addWord(Word word) {
    _allWords.add(word);
    saveWords();
  }

  void updateWord(Word updatedWord) {
    final index = _allWords.indexWhere((w) => w.id == updatedWord.id);
    if (index != -1) {
      _allWords[index] = updatedWord;
      saveWords();
    }
  }

  void deleteWord(Word word) {
    _allWords.removeWhere((w) => w.id == word.id);
    saveWords();
  }

  List<Word> get bookmarkedWords => _allWords.where((w) => w.isBookmarked).toList();
  List<Word> get idioms => _allWords.where((w) => w.isIdiom).toList();
}
