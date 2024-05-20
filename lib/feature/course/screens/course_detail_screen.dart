import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/core/data/model/course.dart';
import 'package:myapp/core/data/model/local_api.dart';
import 'package:myapp/feature/course/widgets/calendar/calendar.dart';
import 'package:myapp/feature/course/widgets/documentation/documentation.dart';
import 'package:myapp/feature/payment/payment.dart';

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
  final TextEditingController _reviewController = TextEditingController();

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
    return FutureBuilder<Course>(
      future: StepikApiService().fetchCourseDetails(widget.course.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null) {
          return _buildErrorWidget();
        } else {
          final Course courseDetails = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              title: Text(courseDetails.name),
            ),
            body: ListView(
              children: [
                _buildCourseDetails(courseDetails),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (courseDetails.isFree) {
                  _navigateToDocumentation(context);
                } else {
                  _showRatingConfirmation(context, courseDetails.id);
                }
              },
              child: courseDetails.isFree
                  ? const Icon(Icons.file_copy)
                  : const Icon(Icons.shopping_cart),
            ),
          );
        }
      },
    );
  }

  void _showRatingConfirmation(BuildContext context, int id) async {
    if (_userRating > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Спасибо за ваш отзыв!'),
        ),
      );
    } else {
      if (widget.course.isFree) {
        _navigateToDocumentation(context); // Pass the context here
      } else {
        _enrollInCourse();
      }
    }
  }

  Widget _buildCourseDetails(Course courseDetails) {
    return Padding(
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
      ),
    );
  }

  Widget _buildStarRating() {
    return Row(
      children: List.generate(
        4,
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

    // Показать уведомление после установки рейтинга
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
    // Список имён для имитации реальных отзывов
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
            color: Colors.white,
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
            // Случайный выбор имени
            String name = names[index % names.length];
            return Card(
              color: Colors.white, // Задний фон белый
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
            backgroundColor: Colors.white, // Чёрный цвет текста
            side: const BorderSide(color: Colors.black), // Чёрная обводка
          ),
          child: const Text('Отправить'),
        ),
      ],
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

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    print('Toggling favorite status for course ${widget.course.id}');
  }

  void _enrollInCourse() {
    _openPaymentScreen();
    print('Enrolling user in the course ${widget.course.id}');
  }

  void _navigateToDocumentation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CourseReadingScreen(
          courseId: 1,
        ),
      ),
    );
  }

  void _openPaymentScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PaymentScreen()),
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
    // Отправить отзыв на сервер
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white, // Задний фон белый
        content: Text(
          'Отзыв отправлен: $review',
          style: const TextStyle(
              color: Colors.black), // Текст чёрного цвета для контраста
        ),
      ),
    );
    _reviewController.clear();
  }
}
