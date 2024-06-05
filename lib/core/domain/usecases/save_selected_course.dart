
import 'package:myapp/core/domain/repositories/course_repository.dart';

class SaveSelectedCourse {
  final CourseRepository repository;

  SaveSelectedCourse(this.repository);

  Future<void> execute(int id) async {
    return await repository.saveSelectedCourse(id);
  }
}
