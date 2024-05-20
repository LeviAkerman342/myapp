import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:myapp/core/data/model/course.dart';

class CourseRepository {
  Future<Course> getCourse(int courseId) async {
    String jsonString = await _loadCourseJson(courseId);
    Map<String, dynamic> jsonData = json.decode(jsonString);
    Course course = Course.fromJson(jsonData);
    return course;
  }

  Future<String> _loadCourseJson(int courseId) async {
    // Динамически выбираем путь к файлу JSON на основе courseId
    String filePath = 'json/course_$courseId.json';
    return await rootBundle.loadString(filePath);
  }
}
