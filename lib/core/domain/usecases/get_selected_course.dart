import 'package:myapp/core/data/model/course.dart';

import '../repositories/course_repository.dart';

class GetSelectedCourse {
  final CourseRepository repository;

  GetSelectedCourse(this.repository);

  Future<Course?> execute(int id) async {
    return await repository.getSelectedCourse(id);
  }
}
