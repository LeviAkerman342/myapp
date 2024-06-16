class Course {
  final int id;
  final String imageUrl;
  final String name;
  final String description;
  final int lessons;
  final int tests;
  final String documentation;
  final double price;
  final bool isFree;
  final double rating;
  final int students;
  final List<String>? topics;
  final String difficultyLevel;
  final String duration;
  final double courseCost;
  final List<String> tags;
  bool isPaid;

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
    required this.tags,
    this.isPaid = false,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      imageUrl: json['imageUrl'],
      name: json['name'],
      description: json['description'],
      lessons: json['lessons'],
      tests: json['tests'],
      documentation: json['documentation'],
      price: json['price'] ?? 0.0,
      rating: json['rating'] ?? 0.0,
      students: json['students'] ?? 0,
      isFree: json['isFree'] ?? false,
      difficultyLevel: json['difficultyLevel'],
      duration: json['duration'],
      courseCost: json['courseCost'] ?? 0.0,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
    );
  }
}