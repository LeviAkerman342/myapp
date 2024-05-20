import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:myapp/core/data/model/course.dart';
import 'package:myapp/core/services/local_storage/local_storage_curse.dart';
import 'package:myapp/feature/bottom_bar/bottom_bar.dart';
import 'package:myapp/feature/course/widgets/course_card/course_card.dart';
import 'package:myapp/feature/course/widgets/course_card/model/course_model.dart';
import 'package:myapp/feature/course/widgets/custom_card/custom_card.dart';
import 'package:myapp/feature/course/widgets/nav_bar/nav_bar.dart';
import 'package:myapp/feature/course/widgets/tegs_education/tegs_education.dart';
import 'package:myapp/feature/course/widgets/theme_manage/theme_manage.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late ThemeManager _themeManager;
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;
  List<CourseModel> courseList = [];
  String selectedTag = '';

  @override
  void initState() {
    super.initState();
    _themeManager = ThemeManager();
    _pageController = PageController(viewportFraction: 0.8);
    _startTimer();
    courseList = _getCourseList();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < LocalStorageService.courses.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  List<CourseModel> _getCourseList() {
    return [
      CourseModel(
        status1: 'Погружение в JavaScript: для начинающих',
        status2:
            'Плавное и последовательное погружение в удивительный мир программирования на языке JavaScript для абсолютных новичков.',
        days: 10,
        info: '100Р',
        tags: ['JS'],
      ),
      CourseModel(
        status1: 'JavaScript. A3 Задачи',
        status2:
            'Задачи на программирования на языке JavaScript, формат ввода-вывода делает задачи похожими на задачи на других языка программирования. В курсе используется синтаксис современного стандарта ES6.',
        days: 20,
        info: '120р',
        tags: ['JS'],
      ),
      CourseModel(
        status1: 'Разработка веб-сервисов на Golang (Go)',
        status2:
            'Этот курс был создан в 2017 году на основе внедрения языка Go в Почту Mail.ru с целью развития рынка гоферов в РФ.',
        days: 10,
        info: '300р',
        tags: ['Golang'],
      ),
      CourseModel(
        status1: 'Разработка веб-приложений на Node.js',
        status2:
            'Авторский курс познакомит слушателей с платформой Node.js. Он будет интересен разработчикам, которые имеют представление о JavaScript, но только начинают знакомство с разработкой серверных приложений на этом языке.',
        days: 20,
        info: '450р',
        tags: ['Node'],
      ),
      CourseModel(
        status1: 'Быстрый старт в FastAPI Python',
        status2:
            'FastAPI - это современный, высокопроизводительный веб-фреймворк для создания API-интерфейсов на Python.',
        days: 10,
        info: '600Р',
        tags: ['FastAPI', 'Python'],
      ),
      CourseModel(
        status1: 'C# Тренажер',
        status2:
            'Курс включает в себя множество практических задач по программированию на языке C#, которые способствуют повышению вашего уровня навыков в этой области. ',
        days: 20,
        info: '200р',
        tags: ['C#'],
      ),
    ];
  }

  List<CourseModel> _getFilteredCourses(String tag) {
    if (tag.isEmpty) {
      return List.from(courseList);
    } else {
      List<CourseModel> filteredCourses = courseList
          .where((course) =>
              course.tags.any((t) => t.toLowerCase() == tag.toLowerCase()))
          .toList();

      filteredCourses.sort((a, b) {
        int aIndex = a.tags.indexOf(tag.toUpperCase());
        int bIndex = b.tags.indexOf(tag.toUpperCase());
        return aIndex.compareTo(bIndex);
      });

      return filteredCourses;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _themeManager.themeData,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavBar(
                userIcon: Icons.person,
                userName: 'Hello, Nikita',
                notificationIcon: Icons.notifications,
                backgroundColor: _themeManager.backgroundColor,
                textColor: _themeManager.textColor,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  height: 100,
                  child: TegsEducation(
                    textColor: _themeManager.textColor,
                    onTagTap: (tag) {
                      setState(() {
                        selectedTag = tag;
                        courseList = _getFilteredCourses(tag);
                      });
                    },
                    tags: courseList
                        .expand((course) => course.tags)
                        .toSet()
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 26),
              SizedBox(
                height: 380, // Увеличьте высоту для больших карточек
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: courseList.length,
                  onPageChanged: (int index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    CourseModel course = courseList[index];
                    Color cardColor = _generateRandomColor();
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        border:
                            Border.all(color: Colors.grey), // Add grey border
                      ),
                      child: CourseCard(
                        data: course,
                        textColor: Colors.black,
                        backgroundColor: Colors.white,
                        chipColor: const Color.fromARGB(255, 219, 219, 219),
                        color1: const Color.fromARGB(255, 87, 87, 87),
                        color: cardColor, onPressed: () {  },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: courseList.length,
                      itemBuilder: (context, index) {
                        Course course = LocalStorageService.courses[index];
                        return CustomCard(
                          course: course,
                          backgroundColor: _themeManager.cardBackgroundColor,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _themeManager.toggleTheme();
            });
          },
          backgroundColor: const Color(0xFFD2FF1F),
          child: const Icon(Icons.color_lens),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }

  Color _generateRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(210),
      random.nextInt(210),
      random.nextInt(210),
    );
  }
}
