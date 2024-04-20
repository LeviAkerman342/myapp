import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:myapp/core/data/model/course.dart';
import 'package:myapp/core/services/local_storage/local_storage_curse.dart';
import 'package:myapp/feature/course/screens/course_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Course> _searchResults = [];
  final LocalStorageService _localStorageService = LocalStorageService();

  Future<void> _searchCourses(String query) async {
    setState(() {
      _searchResults = [];
    });

    final Uri url = Uri.parse('YOUR_API_ENDPOINT_HERE');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Course> courses =
          data.map((item) => Course.fromJson(item)).toList();

      final List<Course> filteredCourses = courses.where((course) {
        return course.name.toLowerCase().contains(query.toLowerCase());
      }).toList();

      setState(() {
        _searchResults = filteredCourses;
      });
    } else {
      throw Exception('Failed to load courses');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Поиск курсов'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: (value) {
              _searchCourses(value);
            },
            decoration: const InputDecoration(
              labelText: 'Поиск курсов',
              hintText: 'Введите название курса',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final Course course = _searchResults[index];
                return ListTile(
                  title: Text(course.name),
                  subtitle: Text(course.description),
                  onTap: () {
                    _localStorageService.saveSelectedCourse(course);
                    // Navigate to the CourseDetailScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetailScreen(course: course),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
