class QuizQuestion {
  final String id;
  final String questionText;
  final List<String> answers;

  QuizQuestion({
    required this.id,
    required this.questionText,
    required this.answers,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    List<String> answerList = [];
    if (json['answers'] != null) {
      answerList =
          (json['answers'] as List).map((a) => a['answer'] as String).toList();
    }

    return QuizQuestion(
      id: json['_id'] ?? '',
      questionText: json['questionText'] ?? '',
      answers: answerList,
    );
  }
}

class QuizAnswer {
  final String question;
  final String selectedAnswer;

  QuizAnswer({required this.question, required this.selectedAnswer});

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'selectedAnswer': selectedAnswer,
    };
  }
}
