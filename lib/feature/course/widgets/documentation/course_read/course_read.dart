import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:myapp/core/data/model/course.dart';

class CourseReadingScreen extends StatefulWidget {
  final int courseId;

  const CourseReadingScreen({Key? key, required this.courseId}) : super(key: key);

  @override
  _CourseReadingScreenState createState() => _CourseReadingScreenState();
}

class _CourseReadingScreenState extends State<CourseReadingScreen> {
  late Future<Course> _courseContentFuture;

  @override
  void initState() {
    super.initState();
    _courseContentFuture = _fetchCourseContent(widget.courseId);
  }

  Future<Course> _fetchCourseContent(int courseId) async {
    try {
      final String response = await rootBundle.loadString('assets/course_content_$courseId.json');
      final data = json.decode(response);
      return Course.fromJson(data);
    } catch (e) {
      throw Exception('Ошибка при загрузке содержания курса: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Обучение курсу'),
        backgroundColor: Colors.white, // Set AppBar background color to white
        iconTheme: const IconThemeData(color: Colors.black), // Set icon color to black
      ),
      body: FutureBuilder<Course>(
        future: _courseContentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка загрузки курса: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            Course courseContent = snapshot.data!;
            return _buildCourseContent(courseContent);
          } else {
            return const Center(child: Text('Нет данных для отображения'));
          }
        },
      ),
    );
  }

  Widget _buildCourseContent(Course courseContent) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _courseContentFuture = _fetchCourseContent(widget.courseId);
        });
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: courseContent.topics?.length ?? 0,
        itemBuilder: (context, index) {
          final topic = courseContent.topics![index];
          return GestureDetector(
            onTap: () {
              // Implement navigation to detail screen
            },
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
