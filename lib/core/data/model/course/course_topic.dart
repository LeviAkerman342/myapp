import 'package:myapp/core/domain/entities/course_topic.dart';
import 'package:myapp/feature/course/widgets/documentation/test_quest.dart';


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
      testQuestions: List<TestQuestion>.from(
        json['testQuestions'].map((x) => TestQuestion.fromJson(x)),
      ),
      videoUrl: json['videoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'theory': theory,
      'exampleCode': exampleCode,
      'testQuestions': testQuestions.map((x) => x.toJson()).toList(),
      'videoUrl': videoUrl,
    };
  }
}
