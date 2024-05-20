import 'package:flutter/material.dart';

class ThemeManager {
  bool _isDarkMode = false;

  // Возвращает текущую тему в зависимости от выбранного режима (светлая или темная).
  ThemeData get themeData => _isDarkMode ? darkTheme : lightTheme;

  // Цвет фона, который меняется в зависимости от выбранной темы.
  Color get backgroundColor =>
      _isDarkMode ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 250, 249, 249);

  // Цвет текста, который меняется в зависимости от выбранной темы.
  Color get textColor => _isDarkMode ? Colors.white : Colors.black;

  // Цвет фона карточек, который меняется в зависимости от выбранной темы.
  Color get cardBackgroundColor =>
      _isDarkMode ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 255, 255, 255);

  // Метод для переключения между светлой и темной темами.
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
  }

  // Светлая тема приложения.
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: ThemeData.light().textTheme.apply(
      bodyColor: const Color.fromARGB(255, 0, 0, 0),
      displayColor: Colors.black,
    ),
    colorScheme: const ColorScheme.light(
      surface: Color.fromARGB(255, 0, 0, 0),
    ),
  );

  // Темная тема приложения.
  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: ThemeData.dark().textTheme.apply(
      bodyColor: const Color.fromARGB(255, 238, 238, 238), 
      // Изменен цвет текста для темной темы
      displayColor: const Color.fromARGB(255, 12, 12, 12),
    ),
    colorScheme: const ColorScheme.dark(
      surface: Color.fromARGB(238, 4, 4, 4),
    ),
  );
}
