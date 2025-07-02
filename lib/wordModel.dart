import 'dart:convert';

class Word {
  int id;
  String word;
  String meaning;
  bool isBookmarked;
  bool isIdiom; // Default to false, can be set later if needed
  List<String> synonyms;
  List<String> antonyms;
  List<String> sentences;

  Word({
    required this.id,
    required this.word,
    required this.meaning,
    this.isIdiom = false, // Default to false, can be set later if needed
    this.isBookmarked = false,
    List<String>? synonyms,
    List<String>? antonyms,
    List<String>? sentences,
  })  : synonyms = synonyms ?? [],
        antonyms = antonyms ?? [],
        sentences = sentences ?? [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'word': word,
      'meaning': meaning,
      'isIdiom': isIdiom,
      'isBookmarked': isBookmarked,
      'synonyms': synonyms,
      'antonyms': antonyms,
      'sentences': sentences,
    };
  }

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'],
      word: json['word'],
      meaning: json['meaning'],
      isIdiom: json['isIdiom'] ?? false,
      isBookmarked: json['isBookmarked'] ?? false,
      synonyms: List<String>.from(json['synonyms'] ?? []),
      antonyms: List<String>.from(json['antonyms'] ?? []),
      sentences: List<String>.from(json['sentences'] ?? []),
    );
  }

  String encode() => json.encode(toJson());
  static Word decode(String str) => Word.fromJson(json.decode(str));
}
