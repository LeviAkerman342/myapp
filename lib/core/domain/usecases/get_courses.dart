import 'package:myapp/core/data/model/course.dart';

import '../repositories/course_repository.dart';

class GetCourses {
  final CourseRepository repository;

  GetCourses(this.repository);

  Future<List<Course>> execute() async {
    return await repository.getCourses();
  }
}
