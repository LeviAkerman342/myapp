import 'package:flutter/material.dart';
class ThemeManager {
  late ValueNotifier<bool> _isDarkMode;

  ThemeManager() {
    _isDarkMode = ValueNotifier(false);
  }

  ValueNotifier<bool> get isDarkModeNotifier => _isDarkMode;

  bool get isDarkMode => _isDarkMode.value;

  ThemeData get themeData => _isDarkMode.value ? darkTheme : lightTheme;

  Color get backgroundColor => _isDarkMode.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 250, 249, 249);

  Color get textColor => _isDarkMode.value ? Colors.white : Colors.black;

  Color get cardBackgroundColor => _isDarkMode.value ? const Color.fromARGB(255, 0, 0, 0) : const Color.fromARGB(255, 255, 255, 255);

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
  }

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

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: ThemeData.dark().textTheme.apply(
      bodyColor: const Color.fromARGB(255, 238, 238, 238),
      displayColor: const Color.fromARGB(255, 12, 12, 12),
    ),
    colorScheme: const ColorScheme.dark(
      surface: Color.fromARGB(238, 4, 4, 4),
    ),
  );
}
