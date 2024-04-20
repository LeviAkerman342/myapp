import 'package:flutter/material.dart';
import 'package:myapp/core/data/model/course.dart';
import 'package:myapp/core/services/local_storage/local_storage_curse.dart';
import 'package:myapp/feature/bottom_bar/bottom_bar.dart';
import 'package:myapp/feature/course/widgets/custom_card/custom_card.dart';
import 'package:myapp/feature/course/widgets/nav_bar/nav_bar.dart';
import 'package:myapp/feature/course/widgets/tegs_education/tegs_education.dart'; // Подключаем ваш NavBar

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      textTheme: ThemeData.light().textTheme.apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
          ),
      colorScheme: const ColorScheme.light(
        surface: Colors.white,
      ),
    );

    final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: ThemeData.dark().textTheme.apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
          ),
      colorScheme: const ColorScheme.dark(
        surface: Colors.black,
      ),
    );

    return MaterialApp(
      theme: _isDarkMode ? darkTheme : lightTheme,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NavBar(
                userIcon: Icons.person,
                userName: 'Hello, Nikita',
                notificationIcon: Icons.notifications,
              ),
              const SizedBox(height: 16),
              const TegsEducation(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: LocalStorageService.courses.length,
                      itemBuilder: (context, index) {
                        Course course = LocalStorageService.courses[index];
                        return CustomCard(
                          course: course,
                          backgroundColor: _isDarkMode
                              ? const Color.fromARGB(255, 29, 29, 29)
                              : const Color.fromARGB(255, 133, 133, 133),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _toggleTheme,
          backgroundColor: _isDarkMode
              ? const Color.fromARGB(255, 236, 222, 222)
              : const Color.fromARGB(255, 67, 67, 67),
          child: const Icon(Icons.color_lens),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}
