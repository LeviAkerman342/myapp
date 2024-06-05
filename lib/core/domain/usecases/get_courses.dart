import 'package:myapp/core/data/model/course/course.dart';
import 'package:myapp/core/domain/repositories/course_repository.dart';


class GetCourses {
  final CourseRepository repository;

  GetCourses(this.repository);

  Future<List<Course>> execute() async {
    return await repository.getCourses();
  }
}
