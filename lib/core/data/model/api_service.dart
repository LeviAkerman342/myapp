import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/core/data/model/course.dart';
import 'package:myapp/feature/auntification/I_authentication_repository.dart';

class AuthenticationRepository implements IAuthenticationRepository{
  final String baseUrl =
      'https://learning-courses-back-end.onrender.com/api/v1';

  @override
  Future<void> registerUser({
    required String userName,
    required String email,
    required String fullName,
    required String password,
    required String numberPhone,
  }) async {
    final String registrationUrl = '$baseUrl/Authentication/User/Registration';

    final Map<String, dynamic> requestData = {
      'userName': userName,
      'email': email,
      'fullName': fullName,
      'password': password,
      'numberPhone': numberPhone,
    };

    final jsonData = json.encode(requestData);

    try {
      final response = await http.post(
        Uri.parse(registrationUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      if (response.statusCode == 200) {
        print('Пользователь успешно зарегистрирован');
      } else {
        print('Ошибка при регистрации: ${response.body}');
      }
    } catch (e) {
      print('Ошибка при соединении с сервером: $e');
    }
  }

  Future<Course> fetchCourseDetails(int courseId) async {
    final String courseUrl = '$baseUrl/Course/Details/$courseId';

    try {
      final response = await http.get(
        Uri.parse(courseUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final course = Course.fromJson(jsonData);
        return course;
      } else {
        throw Exception('Ошибка при загрузке данных о курсе');
      }
    } catch (e) {
      throw Exception('Ошибка при соединении с сервером: $e');
    }
  }
}
