import 'package:flutter/material.dart';
import 'package:myapp/core/domain/entities/course_topic.dart';

class TestTab extends StatelessWidget {
  final CourseTopic topic;

  const TestTab({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: topic.testQuestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(topic.testQuestions[index]),
          );
        },
      ),
    );
  }
}
