

import 'package:myapp/core/data/model/course.dart';
import 'package:myapp/core/domain/repositories/course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  @override
  Future<List<Course>> getCourses() async {
    // Здесь должна быть реализация получения данных о курсах
    // из API или локального хранилища
    return [];
  }

  @override
  Future<Course?> getSelectedCourse(int id) async {
    // Здесь должна быть реализация получения данных о выбранном курсе
    // из API или локального хранилища
    return null;
  }

  @override
  Future<void> saveSelectedCourse(int id) async {
    // Здесь должна быть реализация сохранения данных о выбранном курсе
    // в локальное хранилище
  }
}
