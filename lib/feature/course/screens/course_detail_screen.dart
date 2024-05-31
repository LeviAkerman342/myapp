import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/core/data/model/course.dart';
import 'package:myapp/core/services/local_storage/local_storage_curse.dart';
import 'package:myapp/feature/course/widgets/calendar/calendar.dart';
import 'package:myapp/feature/course/widgets/documentation/pages/course_page.dart';
import 'package:myapp/feature/payment/payment.dart';

class CourseDetailScreen extends StatefulWidget {
  final int courseId;

  const CourseDetailScreen(
      {super.key, required this.courseId, required Course course});

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  bool _isFavorite = false;
  double _userRating = 0.0;
  final TextEditingController _reviewController = TextEditingController();

  late Course _course;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _course = LocalStorageService()
        .getAllCourses()
        .firstWhere((course) => course.id == widget.courseId);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(_course.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCourseDetails(_course),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_course.price == 0) {
            _navigateToDocumentation(context);
          } else {
            _navigateToPayment(context);
          }
        },
        child: _course.price == 0
            ? const Icon(Icons.file_copy)
            : const Icon(Icons.shopping_cart),
      ),
    );
  }

  Widget _buildCourseDetails(Course courseDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          courseDetails.imageUrl ??
              'https://cdn.stepik.net/media/cache/images/courses/187490/cover_PV6a4Rz/d9657182ee254b31244717f1b2a21313.png',
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),
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
              'Цена: ${courseDetails.price == 0 ? 'Бесплатно' : '\$${courseDetails.price}'}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: _toggleFavorite,
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            GestureDetector(
              onTap: _openCalendar,
              child: Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 5),
                  Text(
                    'Продолжительность курса: \n${courseDetails.duration}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
          onPressed: () => _navigateToDocumentation(context),
          child: const Text('Перейти'),
        ),
        const SizedBox(height: 20),
        _buildReviewsSection(),
      ],
    );
  }

  Widget _buildStarRating() {
    return Row(
      children: List.generate(
        5,
        (index) => IconButton(
          onPressed: () {
            _setRating(index + 1);
          },
          icon: Icon(
            index < _userRating ? Icons.star : Icons.star_border,
            color: index < _userRating ? Colors.amber : Colors.grey,
          ),
        ),
      ),
    );
  }

  void _setRating(double rating) {
    setState(() {
      _userRating = rating;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color.fromARGB(255, 116, 114, 114),
        content: Text(
          'Спасибо за ваш отзыв!',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildReviewsSection() {
    List<String> names = ['Александр', 'Елена', 'Михаил', 'Анна', 'Иван'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          'Отзывы:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        _buildReviewsSlider(names),
        const SizedBox(height: 20),
        _buildUserReview(),
      ],
    );
  }

  Widget _buildReviewsSlider(List<String> names) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          5,
          (index) {
            String name = names[index % names.length];
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: 200,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 172, 175, 177),
                      child: Text(
                        name[0],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$name',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Очень полезный курс! Рекомендую!',
                      style: TextStyle(
                        fontSize: 14,
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

  Widget _buildUserReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Оставить отзыв:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _reviewController,
          decoration: const InputDecoration(
            hintText: 'Введите ваш отзыв',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            _submitReview(_reviewController.text);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            side: const BorderSide(color: Colors.black),
          ),
          child: const Text('Отправить'),
        ),
      ],
    );
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    print('Toggling favorite status for course ${_course.id}');
  }

  void _navigateToPayment(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PaymentScreen()),
    );
  }

  void _navigateToDocumentation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoursePage(
          courseId: _course.id,
          topics: const [],
        ),
      ),
    );
  }

  void _openCalendar() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarScreen(
          startDate: DateTime.now(),
          courseDuration: 30,
        ),
      ),
    );
  }

  void _submitReview(String review) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          'Отзыв отправлен: $review',
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
    _reviewController.clear();
  }
}
