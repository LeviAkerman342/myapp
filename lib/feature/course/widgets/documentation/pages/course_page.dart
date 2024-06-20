import 'package:flutter/material.dart';
import 'package:myapp/core/data/model/course/course.dart';
import 'package:myapp/core/data/model/course/course_topic.dart';
import 'package:myapp/core/data/repositories/course_repository_impl.dart';
import 'package:myapp/core/domain/entities/course_topic.dart';
import 'package:myapp/feature/course/widgets/documentation/test_quest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/theory_tab.dart';
import '../widgets/test_tab.dart';
import '../widgets/video_tab.dart';

class CoursePage extends StatefulWidget {
  final int courseId;

  const CoursePage({super.key, required this.courseId, Course? course});

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  int _selectedTabIndex = 0;
  final List<CourseTopic> _topics = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadSavedTab();
    _loadTopics();
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

  Future<void> _loadTopics() async {
    try {
      final repository = CourseRepositoryImpl();
      final course = await repository.getSelectedCourse(widget.courseId);
      final topics = course?.topics
              ?.map((topicJson) =>
                  CourseTopicModel.fromJson(topicJson as Map<String, dynamic>))
              .toList() ??
          [];

      setState(() {
        _topics.clear();
        _topics.addAll(topics.isNotEmpty ? topics : _getDefaultTopics());
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      print('Error loading topics: $error');
    }
  }

  List<CourseTopic> _getDefaultTopics() {
    return [
      CourseTopic(
        title: 'Модуль 1: Переменные и Типы данных',
        theory:
            'В Dart есть следующие встроенные типы данных: Numbers — числовые типы данных, их всего два: int и double. Strings — последовательность символов в кодировке UTF-16. Booleans — для работы с логическими значениями в языке Dart есть тип с именем bool. Lists — список, представляющий собой набор значений либо просто массив. Sets — неупорядоченная коллекция уникальных элементов. Maps — коллекция, которая хранит информацию ключ-значение. Runes — последовательность символов в кодировке UTF-32. Symbols — символы являются типом Symbol. Для объявления переменных используются ключевые слова var и dynamic. Ключевые слова final и const используются для объявления констант.',
        exampleCode:
            'int age = 30; \nString name = "John"; \nbool isActive = true;',
        testQuestions: [
          TestQuestion(
            question: 'Какой тип данных используется для целых чисел?',
            options: ['String', 'int', 'double'],
            answer: 'int',
          ),
          TestQuestion(
            question: 'Что используется для логических значений?',
            options: ['bool', 'int', 'String'],
            answer: 'bool',
          ),
        ],
        videoUrl: 'https://youtu.be/dQw4w9WgXcQ',
      ),
      CourseTopic(
        title: 'Модуль 3: Функции и Методы',
        theory:
            'Функции в Dart — это основная структура для организации кода и выполнения операций. Они могут принимать аргументы и возвращать значения. Методы — это функции, которые определены внутри классов и объектов. Функции объявляются с использованием ключевого слова void или типа возвращаемого значения.',
        exampleCode:
            'int add(int a, int b) { return a + b; } \nvoid main() { print(add(5, 3)); }',
        testQuestions: [
          TestQuestion(
            question:
                'Какое ключевое слово используется для объявления функции?',
            options: ['void', 'func', 'method'],
            answer: 'void',
          ),
          TestQuestion(
            question: 'Что такое метод?',
            options: ['Функция внутри класса', 'Тип данных', 'Константа'],
            answer: 'Функция внутри класса',
          ),
        ],
        videoUrl: 'https://youtu.be/oHg5SJYRHA0',
      ),
      CourseTopic(
        title: 'Модуль 4: Операторы',
        theory:
            'Dart поддерживает различные операторы, включая арифметические, логические, сравнения и присваивания. Операторы помогают выполнять операции над переменными и значениями.',
        exampleCode: 'int a = 10; \na += 5; \nbool isTrue = (a == 15);',
        testQuestions: [
          TestQuestion(
            question: 'Что делает оператор +=?',
            options: [
              'Прибавляет и присваивает',
              'Умножает и присваивает',
              'Вычитает и присваивает'
            ],
            answer: 'Прибавляет и присваивает',
          ),
          TestQuestion(
            question: 'Что возвращает оператор ==?',
            options: ['Логическое значение', 'Числовое значение', 'Строку'],
            answer: 'Логическое значение',
          ),
        ],
        videoUrl: 'https://youtu.be/6_b7RDuLwcI',
      ),
      CourseTopic(
        title: 'Модуль 5: Условия и Циклы',
        theory:
            'Условия (if, else, switch) и циклы (for, while, do-while) являются основными структурами управления потоком в Dart. Они позволяют выполнять код в зависимости от условий и повторять выполнение кода.',
        exampleCode:
            'for (int i = 0; i < 5; i++) { print(i); } \nif (a > b) { print("a больше b"); }',
        testQuestions: [
          TestQuestion(
            question: 'Какой цикл используется для повторения кода с условием?',
            options: ['for', 'if', 'switch'],
            answer: 'for',
          ),
          TestQuestion(
            question: 'Что такое if?',
            options: ['Условный оператор', 'Цикл', 'Метод'],
            answer: 'Условный оператор',
          ),
        ],
        videoUrl: 'https://youtu.be/FTQbiNvZqaY',
      ),
      CourseTopic(
        title: 'Модуль 6: Классы и Объекты',
        theory:
            'Классы в Dart используются для определения объектов. Они содержат поля и методы, которые определяют свойства и поведение объектов. Объекты — это экземпляры классов.',
        exampleCode:
            'class Person { \n  String name; \n  int age; \n  Person(this.name, this.age); \n} \nvoid main() { \n  var person = Person("Alice", 30); \n  print(person.name); \n}',
        testQuestions: [
          TestQuestion(
            question: 'Что такое класс?',
            options: ['Шаблон для создания объектов', 'Функция', 'Переменная'],
            answer: 'Шаблон для создания объектов',
          ),
          TestQuestion(
            question: 'Что такое объект?',
            options: ['Экземпляр класса', 'Тип данных', 'Константа'],
            answer: 'Экземпляр класса',
          ),
        ],
        videoUrl: 'https://youtu.be/ZZ5LpwO-An4',
      ),
      CourseTopic(
        title: 'Модуль 7: Наследование и Полиморфизм',
        theory:
            'Наследование позволяет создавать новые классы на основе существующих, что способствует повторному использованию кода. Полиморфизм позволяет использовать объекты производных классов как объекты базовых классов.',
        exampleCode:
            'class Animal { \n  void makeSound() { print("Animal sound"); } \n} \nclass Dog extends Animal { \n  @override \n  void makeSound() { print("Bark"); } \n} \nvoid main() { \n  Animal myDog = Dog(); \n  myDog.makeSound(); \n}',
        testQuestions: [
          TestQuestion(
            question: 'Что такое наследование?',
            options: [
              'Процесс создания нового класса на основе существующего',
              'Процесс объявления переменной',
              'Процесс выполнения операции'
            ],
            answer: 'Процесс создания нового класса на основе существующего',
          ),
          TestQuestion(
            question: 'Что такое полиморфизм?',
            options: [
              'Способность объектов разных классов использовать один и тот же интерфейс',
              'Создание объектов',
              'Тип данных'
            ],
            answer:
                'Способность объектов разных классов использовать один и тот же интерфейс',
          ),
        ],
        videoUrl: 'https://youtu.be/djV11Xbc914',
      ),
      CourseTopic(
        title: 'Модуль 8: Асинхронное программирование',
        theory:
            'Dart поддерживает асинхронное программирование с использованием async и await. Эти ключевые слова позволяют писать асинхронный код, который выглядит как синхронный.',
        exampleCode:
            'Future<void> fetchData() async { \n  var result = await fetchFromNetwork(); \n  print(result); \n} \nvoid main() { fetchData(); }',
        testQuestions: [
          TestQuestion(
            question:
                'Какое ключевое слово используется для обозначения асинхронной функции?',
            options: ['async', 'await', 'Future'],
            answer: 'async',
          ),
          TestQuestion(
            question:
                'Что используется для ожидания выполнения асинхронной операции?',
            options: ['async', 'await', 'Future'],
            answer: 'await',
          ),
        ],
        videoUrl: 'https://youtu.be/m3lt-Q7u2Ow',
      ),
      CourseTopic(
        title: 'Модуль 9: Работа с файлами и сетью',
        theory:
            'Dart предоставляет мощные библиотеки для работы с файлами и сетью. Вы можете использовать классы File и HttpClient для чтения и записи данных, а также для выполнения сетевых запросов.',
        exampleCode:
            'import \'dart:io\'; \nvoid main() async { \n  var file = File(\'example.txt\'); \n  var contents = await file.readAsString(); \n  print(contents); \n}',
        testQuestions: [
          TestQuestion(
            question: 'Какой класс используется для работы с файлами?',
            options: ['File', 'HttpClient', 'Future'],
            answer: 'File',
          ),
          TestQuestion(
            question:
                'Какой класс используется для выполнения сетевых запросов?',
            options: ['File', 'HttpClient', 'Future'],
            answer: 'HttpClient',
          ),
        ],
        videoUrl: 'https://youtu.be/L_jWHffIx5E',
      ),
      CourseTopic(
        title: 'Модуль 10: Обработка ошибок',
        theory:
            'Dart поддерживает обработку ошибок с использованием try, catch и finally. Эти ключевые слова помогают перехватывать исключения и выполнять код для их обработки.',
        exampleCode:
            'void main() { \n  try { \n    int result = 5 ~/ 0; \n  } catch (e) { \n    print("Error"); \n  } finally { \n    print("This always runs."); \n  } \n}',
        testQuestions: [
          TestQuestion(
            question:
                'Какое ключевое слово используется для перехвата исключений?',
            options: ['catch', 'try', 'finally'],
            answer: 'catch',
          ),
          TestQuestion(
            question:
                'Какое ключевое слово используется для выполнения кода в любом случае?',
            options: ['finally', 'catch', 'try'],
            answer: 'finally',
          ),
        ],
        videoUrl: 'https://youtu.be/EqWRaAF6_WY',
      ),
      CourseTopic(
        title: 'Модуль 11: Генераторы',
        theory:
            'Генераторы в Dart позволяют создавать последовательности значений с использованием ключевых слов sync* и async*. Они облегчают создание и управление потоками данных.',
        exampleCode:
            'Iterable<int> getNumbers() sync* { \n  yield 1; \n  yield 2; \n  yield 3; \n} \nvoid main() { \n  var numbers = getNumbers(); \n  numbers.forEach(print); \n}',
        testQuestions: [
          TestQuestion(
            question:
                'Какое ключевое слово используется для синхронного генератора?',
            options: ['sync*', 'async*', 'yield*'],
            answer: 'sync*',
          ),
          TestQuestion(
            question: 'Что делает ключевое слово yield?',
            options: [
              'Возвращает значение из генератора',
              'Объявляет переменную',
              'Начинает цикл'
            ],
            answer: 'Возвращает значение из генератора',
          ),
        ],
        videoUrl: 'https://youtu.be/ZXsQAXx_ao0',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Курс'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
        backgroundColor: Colors.white,
      );
    }

    if (_hasError || _topics.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Курс'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: const Center(
          child: Text('No topics available for this course'),
        ),
        backgroundColor: Colors.white,
      );
    }

    return DefaultTabController(
      length: _topics.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Курс: ${_topics[_selectedTabIndex].title}'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          bottom: TabBar(
            isScrollable: true,
            tabs: _topics.map((topic) => Tab(text: topic.title)).toList(),
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            onTap: (index) {
              _saveTabIndex(index);
              setState(() {
                _selectedTabIndex = index;
              });
            },
          ),
        ),
        body: Container(
          color: Colors.white,
          child: TabBarView(
            children: _topics.map((topic) {
              return TopicTabs(topic: topic);
            }).toList(),
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class TopicTabs extends StatelessWidget {
  final CourseTopic topic;

  const TopicTabs({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Теория'),
              Tab(text: 'Тест'),
              Tab(text: 'Видео'),
            ],
            labelColor: Colors.black,
            indicatorColor: Colors.black,
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Container(
          color: Colors.white,
          child: TabBarView(
            children: [
              TheoryTab(topic: topic),
              TestTab(topic: topic),
              VideoTab(topic: topic),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
