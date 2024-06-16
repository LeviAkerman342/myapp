import 'package:flutter/material.dart';
import 'package:myapp/feature/story/story.dart';
import 'dart:async';
import 'dart:math';
import 'package:shimmer/shimmer.dart';

import 'package:myapp/feature/bottom_bar/bottom_bar.dart';
import 'package:myapp/feature/course/widgets/course_card/course_card.dart';
import 'package:myapp/feature/course/widgets/course_card/model/course_model.dart';
import 'package:myapp/feature/course/widgets/custom_card/custom_card.dart';
import 'package:myapp/feature/course/widgets/nav_bar/nav_bar.dart';
import 'package:myapp/feature/course/widgets/tegs_education/tegs_education.dart';
import 'package:myapp/feature/course/widgets/theme_manage/theme_manage.dart';

import '../../../core/data/model/course/course.dart';

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

  final List<Map<String, String>> stories = [
    {'type': 'image', 'url': 'https://i.pinimg.com/564x/e6/0d/a3/e60da318b135e5130c1d45e7789767af.jpg'},
    {'type': 'image', 'url': 'https://i.pinimg.com/564x/f9/47/bf/f947bfbb294cff3ab27d78b0c059870d.jpg'},
    {'type': 'image', 'url': 'https://i.pinimg.com/564x/f7/4e/0b/f74e0bd73320281938ec3ea61738c376.jpg'},
    {'type': 'gif', 'url': 'https://i.pinimg.com/originals/0f/b9/4d/0fb94dff52a5935e105ec497a0c010a5.gif'}
  ];

  @override
  void initState() {
    super.initState();
    _themeManager = ThemeManager();
    _pageController = PageController(viewportFraction: 0.8);
    _startTimer();
    courseList = _getCourseList().cast<CourseModel>();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  List<Widget> _buildShimmerLoadingCards() {
    return List.generate(6, (index) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
      );
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < courseList.length - 1) {
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
        status1: 'Введение в Flutter',
        status2:
            'Основы разработки мобильных приложений с использованием кроссплатформенного фреймворка Flutter и языка Dart.',
        days: 10,
        info: '500Р',
        tags: ['Flutter','Dart','Android/IOS'],
        imageUrl:
            'https://poiskovoe-prodvizhenie.ru/wp-content/uploads/flutter.jpg',
      ),
      CourseModel(
        status1: 'Java Тренажер',
        status2:
            'Курс включает в себя разнообразные практические задачи по программированию, которые помогут улучшить ваш уровень программирования на Java',
        days: 10,
        info: '100Р',
        tags: ['Java'],
        imageUrl:
            'https://cdn.stepik.net/media/cache/images/courses/182389/cover_3Fr0MKV/109a98256229f2e0a016d801aa271524.jpg',
      ),
      CourseModel(
        status1: 'Основы веб-верстки с HTML и CSS',
        status2:
            'Изучаем основы Web. В ходе курса вы познакомитесь с базовыми веб-технологиями (html и css)',
        days: 20,
        info: '120р',
        tags: ['Web'],
        imageUrl:
            'https://cdn.stepik.net/media/cache/images/courses/129827/cover_sOA4fOO/80cf7f642cac53d02e36feb6ef2d454d.png',
      ),
      CourseModel(
        status1: 'Интерактивный тренажер по SQL',
        status2:
            'В курсе большинство шагов — это практические задания на создание SQL-запросов.',
        days: 10,
        info: '300р',
        tags: ['SQL'],
        imageUrl:
            'https://cdn.stepik.net/media/cache/images/courses/63054/cover_foIuz1t/6bc976a3abd69e9e3e5163a5973a8ccf.jpg',
      ),
      CourseModel(
        status1: 'Анимация в After Effects',
        status2:
            'Это всего лишь ознакомительный фрагмент курса «Анимация в After Effects».',
        days: 20,
        info: '450р',
        tags: ['AF'],
        imageUrl: 'https://cdn.stepik.net/media/users/196007098/avatar.png',
      ),
      CourseModel(
        status1: 'Быстрый старт в FastAPI Python',
        status2:
            'FastAPI - это современный, высокопроизводительный веб-фреймворк для создания API-интерфейсов на Python.',
        days: 10,
        info: '600Р',
        tags: ['FastAPI', 'Python'],
        imageUrl: '',
      ),
      CourseModel(
        status1: 'ОСНОВЫ АЛГОРИТМИЗАЦИИ И ПРОГРАММИРОВАНИЯ',
        status2:
            'Программа учебной дисциплины является частью основной профессиональной образовательной программы',
        days: 20,
        info: '200р',
        tags: ['C#'],
        imageUrl:
            'https://cdn.stepik.net/media/cache/images/courses/61349/cover_wb46k6Q/183c84c4d4b0535438ba7f2aa7dac0d6.jpg',
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
                userName: 'Приветствуем в Skillwave',
                notificationIcon: Icons.notifications,
                backgroundColor: _themeManager.backgroundColor,
                textColor: _themeManager.textColor,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: StoryWidget(stories: stories), 
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
                height: 380,
                child: courseList.isEmpty
                    ? PageView(
                        children: _buildShimmerLoadingCards(),
                      )
                    : PageView.builder(
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
                              border: Border.all(color: Colors.grey),
                            ),
                            child: CourseCard(
                              data: course,
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              chipColor: const Color.fromARGB(255, 219, 219, 219),
                              color1: const Color.fromARGB(255, 87, 87, 87),
                              color: cardColor,
                              onPressed: () {},
                              context: context,
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
                    courseList.isEmpty
                        ? Column(
                            children: _buildShimmerLoadingCards(),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: courseList.length,
                            itemBuilder: (context, index) {
                              CourseModel course = courseList[index];
                              return CustomCard(
                                course: Course(
                                  id: index,
                                  imageUrl: course.imageUrl.isEmpty
                                      ? "https://i.pinimg.com/originals/b0/a4/2a/b0a42aaf321b271aa955fec0c3f63dce.gif"
                                      : course.imageUrl,
                                  name: course.status1,
                                  description: course.status2,
                                  lessons: course.days,
                                  tests: 0,
                                  documentation: '',
                                  price: double.parse(course.info.replaceAll(
                                      RegExp(r'[^0-9.]'), '')),
                                  rating: 0.0,
                                  students: 0,
                                  isFree: false,
                                  difficultyLevel: '',
                                  duration: '',
                                  courseCost: 0.0,
                                  tags: course.tags,
                                ),
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
          backgroundColor: const Color.fromARGB(255, 118, 34, 173),
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
