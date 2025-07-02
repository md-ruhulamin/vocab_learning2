class QuizQuestion {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final bool isSynonym;
  final bool isMeaning; // NEW

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.isSynonym = false,
    this.isMeaning = false,
  });
}