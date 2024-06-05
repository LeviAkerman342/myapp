import 'package:flutter/material.dart';
import 'package:myapp/core/data/model/course/course.dart';
import 'package:myapp/core/data/repositories/course_repository_impl.dart';
import 'package:myapp/core/domain/usecases/get_courses.dart';
import 'course_page.dart';

class CoursesListPage extends StatelessWidget {
  final GetCourses getCoursesUseCase = GetCourses(CourseRepositoryImpl());

  CoursesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Course>>(
      future: getCoursesUseCase.execute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No courses available'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final course = snapshot.data![index];
              return ListTile(
                title: Text(course.name),
                subtitle: Text(course.description),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CoursePage(courseId: course.id),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
