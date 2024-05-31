

import 'package:myapp/core/domain/entities/course_topic.dart';

class CourseTopicModel extends CourseTopic {
  CourseTopicModel({
    required super.title,
    required super.theory,
    required super.exampleCode,
    required super.testQuestions,
    required super.videoUrl,
  });

  factory CourseTopicModel.fromJson(Map<String, dynamic> json) {
    return CourseTopicModel(
      title: json['title'],
      theory: json['theory'],
      exampleCode: json['exampleCode'],
      testQuestions: List<String>.from(json['testQuestions']),
      videoUrl: json['videoUrl'],
    );
  }
}
