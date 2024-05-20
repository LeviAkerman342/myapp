import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/core/data/model/course.dart';
import 'package:myapp/feature/auntification/I_authentication_repository.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final String baseUrl = 'https://learning-courses-back-end.onrender.com/api/v1';

  @override
  Future<void> registerUser({
    required String userName,
    required String email,
    required String fullName,
    required String password,
    required String numberPhone,
  }) async {
    final Uri url = Uri.parse('$baseUrl/Authentication/User/Registration');
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'userName': userName,
      'email': email,
      'fullName': fullName,
      'password': password,
      'numberPhone': numberPhone,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Registration successful
      print('Registration successful');
      print(response.body); // Вывод ответа сервера
    } else {
      // Registration failed
      print('Registration failed: ${response.body}');
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

  Future<void> authenticateUser(String emailOrName, String password) async {
    final Uri url = Uri.parse('$baseUrl/Authentication/User?EmailOrName=$emailOrName&Password=$password');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Authentication successful
      print('Authentication successful');
      print(response.body); // Вывод ответа сервера
    } else {
      // Authentication failed
      print('Authentication failed: ${response.body}');
    }
  }
}
