// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/core/data/model/course.dart';
import 'package:myapp/core/data/model/local_api.dart';


class CourseDetailScreen extends StatefulWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  bool _isFavorite = false;
  double _userRating = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.name),
      ),
      body: FutureBuilder<Course>(
        future: _fetchCourseDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return _buildErrorWidget();
          } else {
            final Course? courseDetails = snapshot.data;
            if (courseDetails != null) {
              return _buildCourseDetails(courseDetails);
            } else {
              return _buildErrorWidget();
            }
          }
        },
      ),
    );
  }

  Widget _buildCourseDetails(Course courseDetails) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            courseDetails.name,
            style: GoogleFonts.nunito(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Описание:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            courseDetails.description,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Что вы узнаете:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (courseDetails.topics ?? []).map<Widget>((topic) {
              return Text(
                '- $topic',
                style: const TextStyle(
                  fontSize: 16,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Цена: ${courseDetails.isFree ? 'Бесплатно' : '${courseDetails.price}'}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  _toggleFavorite();
                },
                icon: AnimatedIcon(
                  icon: AnimatedIcons.add_event,
                  progress: _animationController,
                  color: _isFavorite ? Colors.pink : Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Продолжительность курса: ${courseDetails.duration}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'Рейтинг курса:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              _buildStarRating(),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Количество студентов: ${courseDetails.students}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Документация:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          TextButton(
            onPressed: () {
              // Add logic for navigating to documentation
            },
            child: const Text('Перейти'),
          ),
          const SizedBox(height: 20),
          _buildReviewsSlider(),
        ],
      ),
    );
  }

  Widget _buildStarRating() {
    return Row(
      children: List.generate(
        5,
        (index) => IconButton(
          onPressed: () {
            _setRating(index + 1);
            _animationController.reset();
            _animationController.forward();
          },
          icon: Icon(
            index < _userRating.floor() ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }

  Widget _buildReviewsSlider() {
    // This is a placeholder for the reviews slider
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          5,
          (index) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: 200,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Отзыв ${index + 1}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Очень полезный курс! Рекомендую!',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return const Center(
      child: Text(
        'Ошибка загрузки данных о курсе',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<Course> _fetchCourseDetails() async {
    try {
      final apiService = StepikApiService();
      final apiCourse = await apiService.fetchCourseDetails(widget.course.id);
      return apiCourse;
    } catch (e) {
      return widget.course;
    }
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    // Add logic for updating favorite status on backend
  }

  void _setRating(double rating) async {
    setState(() {
      _userRating = rating;
    });
    try {
      final apiService = StepikApiService();
      await apiService.updateCourseRating(widget.course.id, rating);
      // Handle success
    } catch (e) {
      // Handle error
      setState(() {
        // Revert rating if update fails
        _userRating = 0.0;
      });
    }
  }
}