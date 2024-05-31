import 'package:flutter/material.dart';

import 'package:myapp/core/data/model/course.dart';
import 'package:myapp/core/services/local_storage/local_storage_curse.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Course> _searchResults = [];
  Course? _selectedCourse;
  final LocalStorageService _localStorageService = LocalStorageService();

  Future<void> _searchCourses(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final List<Course> allCourses = _localStorageService.getAllCourses();
    final List<Course> filteredCourses = allCourses.where((course) {
      return course.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _searchResults = filteredCourses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Поиск курсов',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _searchCourses,
              decoration: InputDecoration(
                labelText: 'Поиск курсов',
                hintText: 'Введите название курса',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _selectedCourse != null
                ? Card(
                    key: ValueKey(_selectedCourse!.id),
                    child: ListTile(
                      title: Text(_selectedCourse!.name),
                      subtitle: Text(_selectedCourse!.description),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => CourseDetailScreen(
                        //       course: _selectedCourse!!, courseId: null,
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                  )
                : const SizedBox(),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _searchResults.isEmpty
                  ? const Center(
                      child: Text('Нет результатов'),
                    )
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final Course course = _searchResults[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCourse = course;
                            });
                          },
                          child: Card(
                            key: ValueKey(course.id),
                            margin: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(course.imageUrl),
                              ),
                              title: Text(course.name),
                              subtitle: Text(course.description),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
