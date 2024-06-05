
import 'package:myapp/core/data/model/course/course.dart';

abstract class CourseRepository {
  Future<List<Course>> getCourses();
  Future<Course?> getSelectedCourse(int id);
  Future<void> saveSelectedCourse(int id);
}
