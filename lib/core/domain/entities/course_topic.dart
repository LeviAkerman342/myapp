import 'package:myapp/feature/course/widgets/documentation/test_quest.dart';

class CourseTopic {
  final String title;
  final String theory;
  final String exampleCode;
  final List<TestQuestion> testQuestions;
  final String videoUrl;

  CourseTopic({
    required this.title,
    required this.theory,
    required this.exampleCode,
    required this.testQuestions,
    required this.videoUrl,
  });
}