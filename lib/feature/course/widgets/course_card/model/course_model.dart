import 'package:myapp/core/domain/entities/course_info.dart';

class CourseModel extends CourseInfo {
  final String imageUrl; // Добавлено поле для URL изображения

  CourseModel({
    required this.imageUrl, // Добавлено для конструктора
    required super.status1,
    required super.status2,
    required super.days,
    required super.info,
    required super.tags,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      imageUrl: json['imageUrl'], // Извлечение URL изображения из JSON
      status1: json['status1'],
      status2: json['status2'],
      days: json['days'],
      info: json['info'],
      tags: List<String>.from(json['tags']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl, // Добавлено для сериализации в JSON
      'status1': status1,
      'status2': status2,
      'days': days,
      'info': info,
      'tags': tags,
    };
  }
}
