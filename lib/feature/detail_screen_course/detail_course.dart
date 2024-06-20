import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/core/data/model/course/course.dart';
import 'package:myapp/core/utils/local_storage_service.dart';
import 'package:myapp/feature/course/widgets/documentation/pages/course_page.dart';
import 'package:myapp/feature/favorite/favorite_screen.dart';
import 'package:myapp/feature/payment/payment.dart';

class CourseDetailScreen extends StatefulWidget {
  final Course course;

  const CourseDetailScreen({
    super.key,
    required this.course,
  });

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Course _course;
  bool _isFavorite = false;
  double _userRating = 0.0;
  final TextEditingController _reviewController = TextEditingController();
  final LocalStorageService _localStorageService = LocalStorageService();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _course = widget.course;
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    bool isFavorite = await _localStorageService.isFavoriteCourse(_course);
    setState(() {
      _isFavorite = isFavorite;
    });
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
        iconTheme: const IconThemeData(color: Colors.black),
        foregroundColor: Colors.black,
        title: Text(_course.name, style: const TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildCourseDetails(_course),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCoursePage,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  Widget _buildCourseDetails(Course courseDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.network(
            courseDetails.imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          courseDetails.name,
          style: GoogleFonts.nunito(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Описание:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          courseDetails.description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Количество уроков: ${courseDetails.lessons}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Количество тестов: ${courseDetails.tests}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Документация: ${courseDetails.documentation}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Цена: ${courseDetails.price == 0 ? 'Бесплатно' : '\$${courseDetails.price}'}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Рейтинг: ${courseDetails.rating}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Количество студентов: ${courseDetails.students}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Теги курса:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: courseDetails.tags.map((tag) {
            return Chip(
              label: Text(
                tag,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.white,
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        _buildFavoriteButton(),
        const SizedBox(height: 20),
        _buildUserRating(),
        const SizedBox(height: 20),
        _buildReviewsSection(),
        const SizedBox(height: 20),
        _buildNavigateButton(),
      ],
    );
  }

  Widget _buildNavigateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _navigateToCoursePage,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          backgroundColor: const Color.fromARGB(255, 2, 2, 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: const Text(
          'Перейти',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: _toggleFavorite,
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: _isFavorite ? Colors.red : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildUserRating() {
    return Row(
      children: [
        const Text(
          'Рейтинг пользователя:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 10),
        _buildStarRating(),
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
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        content: Text(
          'Рейтинг отправлен!',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
    );
  }

  Widget _buildReviewsSection() {
    List<String> names = ['Alice', 'Bob', 'Charlie'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Отзывы:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        _buildReviewList(names),
        const SizedBox(height: 20),
        _buildUserReview(),
      ],
    );
  }

  Widget _buildReviewList(List<String> names) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: names.length,
        itemBuilder: (context, index) {
          final name = names[index];
          return Container(
            width: 200,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'AR',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    name,
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
            color: Colors.black,
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
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            side: const BorderSide(color: Colors.black),
          ),
          child: const Text('Отправить'),
        ),
      ],
    );
  }

  void _toggleFavorite() async {
    if (_isFavorite) {
      await _localStorageService.removeFavoriteCourse(_course);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          content: Text(
            'Курс удален из избранного',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      );
    } else {
      await _localStorageService.addFavoriteCourse(_course);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          content: Text(
            'Курс добавлен в избранное',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      );
    }

    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _navigateToPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(course: _course),
      ),
    );
  }

  void _navigateToCoursePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoursePage(
          courseId: _course.id,
        ),
      ),
    );
  }

  void _submitReview(String review) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        content: Text(
          'Отзыв отправлен: $review',
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
    );
    _reviewController.clear();
  }
}
