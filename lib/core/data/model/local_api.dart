import 'package:dio/dio.dart';
import 'package:myapp/core/data/model/course.dart';
class StepikApiService {
  static const String authToken = 'kKpT0uT0B1OpmiBgZsNj0bmTeN4ab0r7voPiSNBu';
  static final Dio _dio = Dio();

  /// Получение списка курсов
  Future<List<Course>> fetchCourses() async {
    try {
      final response = await _dio.get(
        '${StepikAPI.baseUrl}/courses',
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> coursesJson = response.data['courses'];
        List<Course> courses = coursesJson
            .map((courseJson) => Course.fromJson(courseJson))
            .toList();
        return courses;
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (error) {
      throw Exception('Failed to load courses: $error');
    }
  }

  /// Получение подробной информации о курсе по его ID
  Future<Course> fetchCourseDetails(int courseId) async {
    try {
      final response = await _dio.get(
        '${StepikAPI.baseUrl}/courses/$courseId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> courseJson = response.data;
        Course course = Course.fromJson(courseJson);
        return course;
      } else {
        throw Exception('Failed to load course details');
      }
    } catch (error) {
      throw Exception('Failed to load course details: $error');
    }
  }
    Future<void> updateCourseRating(int courseId, double rating) async {
    try {
      final response = await _dio.put(
        '${StepikAPI.baseUrl}/courses/$courseId/rating',
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
          },
        ),
        data: {
          'rating': rating,
        },
      );

      if (response.statusCode == 200) {
        // Rating updated successfully
        print('Rating updated successfully');
      } else {
        // Error updating rating
        print('Error updating rating: ${response.statusCode}');
        throw Exception('Failed to update rating');
      }
    } catch (error) {
      throw Exception('Failed to update rating: $error');
    }
  }
}



// Общий URL для Stepik API
class StepikAPI {
  static const String baseUrl = 'https://stepik.org/api';

  /// Создание экземпляра Dio для работы с API
  static final Dio _dio = Dio();

  /// Метод для выполнения GET запроса
  static Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await _dio.get('$baseUrl/$endpoint',
          queryParameters: queryParameters);
      return response;
    } catch (error) {
      throw Exception('Failed to get data: $error');
    }
  }

  /// Метод для выполнения POST запроса
  static Future<Response> post(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      Response response = await _dio.post('$baseUrl/$endpoint', data: data);
      return response;
    } catch (error) {
      throw Exception('Failed to post data: $error');
    }
  }
}