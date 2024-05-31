import 'package:flutter/material.dart';
import 'package:myapp/core/domain/entities/course_topic.dart';
import 'package:myapp/feature/course/widgets/documentation/widgets/test_tab.dart';
import 'package:myapp/feature/course/widgets/documentation/widgets/theory_tab.dart';
import 'package:myapp/feature/course/widgets/documentation/widgets/video_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CoursePage extends StatefulWidget {
  final int courseId;
  final List<CourseTopic> topics;

  const CoursePage({super.key, required this.courseId, required this.topics});

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSavedTab();
  }

  void _loadSavedTab() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedTabIndex = prefs.getInt('selectedTabIndex') ?? 0;
    });
  }

  void _saveTabIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedTabIndex', index);
  }

  @override
  Widget build(BuildContext context) {
    final topic = widget.topics[_selectedTabIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Курс: ${topic.title}'),
      ),
      body: Column(
        children: [
          TabBar(
            onTap: (index) {
              setState(() {
                _selectedTabIndex = index;
                _saveTabIndex(index);
              });
            },
            tabs: const [
              Tab(text: 'Теория'),
              Tab(text: 'Тест'),
              Tab(text: 'Видео'),
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedTabIndex,
              children: [
                TheoryTab(topic: topic),
                TestTab(topic: topic),
                VideoTab(topic: topic),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
