import 'package:shared_preferences/shared_preferences.dart';

import 'package:myapp/core/data/model/course/course.dart';


class LocalStorageService {
  static const String _selectedCourseKey = 'selectedCourse';
  static const String _favoriteCoursesKey = 'favoriteCourses';

  Future<void> saveSelectedCourse(int courseId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_selectedCourseKey, courseId);
  }

  Future<int?> getSelectedCourse() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_selectedCourseKey);
  }

  Future<void> addFavoriteCourse(Course course) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteCourses = prefs.getStringList(_favoriteCoursesKey) ?? [];
    if (!favoriteCourses.contains(course.id.toString())) {
      favoriteCourses.add(course.id.toString());
      await prefs.setStringList(_favoriteCoursesKey, favoriteCourses);
    }
  }

  Future<void> removeFavoriteCourse(Course course) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteCourses = prefs.getStringList(_favoriteCoursesKey) ?? [];
    if (favoriteCourses.contains(course.id.toString())) {
      favoriteCourses.remove(course.id.toString());
      await prefs.setStringList(_favoriteCoursesKey, favoriteCourses);
    }
  }

  Future<bool> isFavoriteCourse(Course course) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteCourses = prefs.getStringList(_favoriteCoursesKey) ?? [];
    return favoriteCourses.contains(course.id.toString());
  }

  Future<List<Course>> getFavoriteCourses() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> favoriteCourseIds = prefs.getStringList(_favoriteCoursesKey) ?? [];
    final List<Course> favoriteCourses = [];

    for (var id in favoriteCourseIds) {
      // Fetch the course details from your data source using the id
      // Here we assume you have a method to fetch course by id, e.g., fetchCourseById(int id)
      final course = await fetchCourseById(int.parse(id));
      if (course != null) {
        favoriteCourses.add(course);
      }
    }

    return favoriteCourses;
  }

  Future<Course?> fetchCourseById(int id) async {
    // Mock implementation, replace with actual data fetching logic
    // return Course instance based on the id
    return null;
  }
}