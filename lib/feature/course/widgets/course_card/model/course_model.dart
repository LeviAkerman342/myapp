class CourseModel {
  final String status1;
  final String status2;
  final int days;
  final String info;
  final List<String> tags; // Define a property to store tags

  CourseModel({
    required this.status1,
    required this.status2,
    required this.days,
    required this.info,
    required this.tags, // Initialize tags in the constructor
  });
}
