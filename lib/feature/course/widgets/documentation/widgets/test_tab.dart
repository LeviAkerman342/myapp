import 'package:flutter/material.dart';
import 'package:myapp/core/domain/entities/course_topic.dart';

class TestTab extends StatefulWidget {
  final CourseTopic topic;

  const TestTab({super.key, required this.topic});

  @override
  _TestTabState createState() => _TestTabState();
}

class _TestTabState extends State<TestTab> {
  Map<int, String?> _selectedAnswers = {};
  Map<int, bool> _isCorrect = {};

  void _handleAnswer(int questionIndex, String selectedAnswer) {
    setState(() {
      _selectedAnswers[questionIndex] = selectedAnswer;
      _isCorrect[questionIndex] =
          selectedAnswer == widget.topic.testQuestions[questionIndex].answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: widget.topic.testQuestions.length,
        itemBuilder: (context, index) {
          final testQuestion = widget.topic.testQuestions[index];
          return Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testQuestion.question,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...testQuestion.options.map((option) {
                    return RadioListTile<String>(
                      title: Text(option),
                      value: option,
                      groupValue: _selectedAnswers[index],
                      onChanged: (value) {
                        _handleAnswer(index, value!);
                      },
                      activeColor: Colors.black,
                    );
                  }).toList(),
                  if (_selectedAnswers[index] != null)
                    Text(
                      _isCorrect[index] == true ? 'Правильно!' : 'Не правильно!',
                      style: TextStyle(
                        color: _isCorrect[index] == true
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
