import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

import 'package:myapp/core/domain/entities/course_topic.dart';

class TheoryTab extends StatelessWidget {
  final CourseTopic topic;

  const TheoryTab({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topic.theory,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          HighlightView(
            topic.exampleCode,
            language: 'dart',
            theme: githubTheme,
            padding: const EdgeInsets.all(16),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
