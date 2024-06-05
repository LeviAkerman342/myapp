class TestQuestion {
  final String question;
  final List<String> options;
  final String answer;

  TestQuestion({
    required this.question,
    required this.options,
    required this.answer,
  });

  factory TestQuestion.fromJson(Map<String, dynamic> json) {
    return TestQuestion(
      question: json['question'],
      options: List<String>.from(json['options']),
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'answer': answer,
    };
  }
}