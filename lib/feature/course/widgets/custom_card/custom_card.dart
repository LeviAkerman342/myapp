import 'package:flutter/material.dart';
import 'package:myapp/core/data/model/course/course.dart';
import 'package:myapp/feature/detail_screen_course/detail_course.dart';
import 'package:myapp/feature/course/widgets/theme_manage/theme_manage.dart';

class CustomCard extends StatelessWidget {
  final Course course;
  final ThemeManager themeManager;

  const CustomCard({
    super.key,
    required this.course,
    required this.themeManager, required Color backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailScreen(
              course: course,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4, // добавляем тень для карточки
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // закругляем углы
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15), // закругляем углы
          child: Container(
            color: themeManager.cardBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9, // соотношение сторон для изображения
                  child: Image.network(
                    course.imageUrl,
                    fit: BoxFit.cover, // заполняем всю доступную область
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    course.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: themeManager.textColor, // цвет текста
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    course.description,
                    style: TextStyle(
                      color: themeManager.textColor, // цвет текста
                    ),
                  ),
                ),
                const SizedBox(height: 4), // добавляем небольшой промежуток
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Занятия: ${course.lessons}',
                        style: TextStyle(
                          color: themeManager.textColor, // цвет текста
                        ),
                      ),
                      Text(
                        'Цена: ${course.price}',
                        style: TextStyle(
                          color: themeManager.textColor, // цвет текста
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4), // добавляем небольшой промежуток
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Бесплатно: ${course.isFree ? "Да" : "Нет"}',
                        style: TextStyle(
                          color: themeManager.textColor, // цвет текста
                        ),
                      ),
                      Text(
                        'Тег${course.tags.join(", ")}',
                        style: TextStyle(
                          color: themeManager.textColor, // цвет текста
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8), // добавляем небольшой промежуток
              ],
            ),
          ),
        ),
      ),
    );
  }
}
