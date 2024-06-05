// topic1_tab.dart
import 'package:flutter/material.dart';
import 'package:myapp/core/domain/entities/course_topic.dart';
import 'package:myapp/feature/course/widgets/tegs_education/topic_tabs.dart';

class Topic1Tab extends StatelessWidget {
  final CourseTopic topic;

  const Topic1Tab({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    // Здесь реализация вашего контента для первой темы
    return TopicTab(topic: topic);
  }
}
