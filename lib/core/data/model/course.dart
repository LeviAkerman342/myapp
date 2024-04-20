class Course {
  /// Уникальный идентификатор курса
  final int id;

  /// URL изображения курса
  final String imageUrl;

  /// Название курса
  final String name;

  /// Описание курса
  final String description;

  /// Количество уроков
  final int lessons;

  /// Количество тестов
  final int tests;

  /// Ссылка на документацию курса
  final String documentation;

  /// Цена курса
  final double price;

  /// Признак бесплатности курса
  final bool isFree;

  /// Рейтинг курса
  final double rating;

  /// Количество студентов
  final int students;

  /// Список тем курса
  final List<String>? topics;

  /// Уровень сложности курса
  final String difficultyLevel;

  /// Продолжительность курса
  final String duration;

  /// Стоимость курса
  final double courseCost;

  Course({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.lessons,
    required this.tests,
    required this.documentation,
    required this.price,
    required this.rating,
    required this.students,
    this.isFree = false,
    this.topics,
    required this.difficultyLevel,
    required this.duration,
    required this.courseCost,
  });

  /// Фабричный метод для создания экземпляра курса из JSON
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'], // Уникальный идентификатор курса
      imageUrl: json['imageUrl'], // URL изображения курса
      name: json['name'], // Название курса
      description: json['description'], // Описание курса
      lessons: json['lessons'], // Количество уроков
      tests: json['tests'], // Количество тестов
      documentation: json['documentation'], // Ссылка на документацию курса
      price: json['price'] ?? 0.0, // Цена курса
      rating: json['rating'] ?? 0.0, // Рейтинг курса
      students: json['students'] ?? 0, // Количество студентов
      isFree: json['isFree'] ?? false, // Признак бесплатности курса
      difficultyLevel: json['difficultyLevel'], // Уровень сложности курса
      duration: json['duration'], // Продолжительность курса
      courseCost: json['courseCost'] ?? 0.0, // Стоимость курса
    );
  }
}
