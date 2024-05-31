import 'package:flutter/material.dart';
import 'package:myapp/core/domain/entities/course_topic.dart';

class TheoryTab extends StatelessWidget {
  final CourseTopic topic;

  const TheoryTab({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Text(topic.theory, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          const Text('Пример кода:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(topic.exampleCode,
              style: const TextStyle(fontSize: 16, fontFamily: 'monospace')),
        ],
      ),
    );
  }
}
