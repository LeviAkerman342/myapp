
import 'package:myapp/core/data/model/course/course.dart';

class LocalStorageService {
  /// Заглушка данных - список курсов
  static List<Course> courses = [
     Course(
      
      id: 1,
      imageUrl:
          "https://poiskovoe-prodvizhenie.ru/wp-content/uploads/flutter.jpg",
      name: "Введение в Flutter",
      description:
          "Основы разработки мобильных приложений с использованием кроссплатформенного фреймворка Flutter и языка Dart.",
      lessons: 16,
      tests: 14,
      documentation: "https://stepik.org/course/188959/promo",
      price: 0,
      rating: 4.5,
      students: 1200,
      difficultyLevel: "Начальный", // Уровень сложности
      duration: "8 недели", // Продолжительность курса
      courseCost: 0, // Стоимость курса
      tags: ["flutter", "dart", "Android/Ios"],
    ),
 
    Course(
      id: 2,
      imageUrl:
          "https://sun9-27.userapi.com/impg/OuTqT8ihzwjLd7meSRJ8Q1F3zKEPHS-un_9obA/Jlrq8ixxfns.jpg?size=230x230&quality=96&sign=846d2dd8e98881d9195d23089856b490&type=album",
      name: "PRO Go. Основы программирования",
      description:
          "Курс посвящен базовым понятиям программирования: типы данных, операторы, переменные, условия, циклы, массивы и функции. Он является вводным и подойдет слушателям с небольшим опытом или вообще без опыта программирования. ",
      lessons: 37,
      tests: 117,
      documentation: "https://stepik.org/course/158385/promo",
      price: 199.99,
      rating: 4.2,
      students: 900,
      difficultyLevel: "Средний", // Уровень сложности
      duration: "8 недель", // Продолжительность курса
      courseCost: 199.99, // Стоимость курса
      tags: ["программирование", "Goland", "основы"],
    ),
     Course(
      id: 3,
      imageUrl:
          "https://cdn.stepik.net/media/cache/images/courses/103167/cover_Jxz6nQL/82505a6c9ac4f2a9778e21aa22dd6d8a.png",
      name: "JavaScript. A3 Задачи",
      description:
          "Задачи на программирования на языке JavaScript, формат ввода-вывода делает задачи похожими на задачи на других языка программирования. .",
      lessons: 28,
      tests: 30,
      documentation: "https://stepik.org/course/158385/promo",
      price: 0,
      rating: 3.2,
      students: 70,
      difficultyLevel: "Лёгкий", // Уровень сложности
      duration: "8 недель", // Продолжительность курса
      courseCost: 300, // Стоимость курса
      tags: ["js", "JS", "Web"],
    ),
      Course(
      id: 4,
      imageUrl:
          "https://cdn.stepik.net/media/cache/images/courses/187490/cover_PV6a4Rz/d9657182ee254b31244717f1b2a21313.png",
      name: "Разработка веб-сервисов на Golang (Go)",
      description:
          "Этот курс был создан в 2017 году на основе внедрения языка Go в Почту Mail.ru с целью развития рынка гоферов в РФ. ",
      lessons: 66 ,
      tests: 20,
      documentation: "https://stepik.org/course/187490/promo?search=3894262931",
      price: 0,
      rating: 3.2,
      students: 100,
      difficultyLevel: "Лёгкий", // Уровень сложности
      duration: "6 недель", // Продолжительность курса
      courseCost: 450, // Стоимость курса
      tags: ["js", "JS", "Web"],
    ),
     Course(
      id: 5,
      imageUrl:
          "https://cdn.stepik.net/media/cache/images/courses/100438/cover_GtwIudP/f85ef58c45b814b76539479b9a49f1d6.png",
      name: "Разработка веб-приложений на Node.js",
      description:
          "Авторский курс познакомит слушателей с платформой Node.js. Он будет интересен разработчикам, которые имеют представление о JavaScript, но только начинают знакомство с разработкой серверных приложений на этом языке.",
      lessons: 26  ,
      tests: 30 ,
      documentation: "https://stepik.org/course/187490/promo?search=3894262931",
      price: 0,
      rating: 4.2,
      students: 200,
      difficultyLevel: "Лёгкий", // Уровень сложности
      duration: "9 недель", // Продолжительность курса
      courseCost: 700, // Стоимость курса
      tags: ["node", "JS", "Web"],
    ),
     Course(
      id: 6,
      imageUrl:
          "https://cdn.stepik.net/media/cache/images/courses/179694/cover_2HZfMiD/e299b805d8a7fec802fadf23c2ab58d5.png",
      name: "Быстрый старт в FastAPI Python",
      description:
          "FastAPI - это современный, высокопроизводительный веб-фреймворк для создания API-интерфейсов на Python.",
      lessons: 20  ,
      tests: 25 ,
      documentation: "https://stepik.org/course/187490/promo?search=3894262931",
      price: 0,
      rating: 4.4,
      students: 300,
      difficultyLevel: "Тяжёлый", // Уровень сложности
      duration: "9 недель", // Продолжительность курса
      courseCost: 100, // Стоимость курса
      tags: ["python", "Api", "Web"],
    ),
  ];

  /// Метод для получения всех курсов
  List<Course> getAllCourses() {
    return courses;
  }

  void saveSelectedCourse(Course selectedCourse) {
    // TODO: Сохранение выбранного курса в локальное хранилище
    // Это место для логики сохранения курса в локальное хранилище
    print('Курс сохранен: ${selectedCourse.name}');
  }

  Future<List<Course>> getFavoriteCourses() async {
    return [];
  }

  Future<void> removeFavoriteCourse(Course course) async {}
}
