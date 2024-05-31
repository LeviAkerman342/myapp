import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _selectedCourseKey = 'selectedCourse';

  Future<void> saveSelectedCourse(int courseId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_selectedCourseKey, courseId);
  }

  Future<int?> getSelectedCourse() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_selectedCourseKey);
  }
}
