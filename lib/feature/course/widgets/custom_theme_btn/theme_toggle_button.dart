import 'package:flutter/material.dart';

class ThemeToggleButton extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onPressed;

  const ThemeToggleButton({super.key, 
    required this.isDarkMode,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor:const Color.fromARGB(255, 239, 244, 241),
      child: const Icon(Icons.color_lens),
    );
  }
}
