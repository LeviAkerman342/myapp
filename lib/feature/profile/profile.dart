import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/feature/profile/update_profile/update_profile.dart';
import 'package:myapp/feature/profile/profile_menu.dart'; // Импорт меню

// Пример класса для хранения данных о пользователе
class UserProfile {
  final String displayName;
  final String email;
  final String photoUrl;

  UserProfile({
    required this.displayName,
    required this.email,
    required this.photoUrl,
  });
}

class ProfileScreen extends StatelessWidget {
  // Пример данных о пользователе
  final userProfile = UserProfile(
    displayName: "Никита Мошой",
    email: "john.doe@example.com",
    photoUrl: "https://example.com/profile.jpg",
  );

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Профиль',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              // Добавьте здесь код выхода из системы
              Get.offAllNamed('/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Обернул в SingleChildScrollView для прокрутки, если контент не помещается на экране
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20), // Добавил небольшой отступ сверху
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(userProfile.photoUrl),
            ),
            const SizedBox(height: 16),
            Text(
              userProfile.displayName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              userProfile.email,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ProfileMenuWidget(
              title:
                  'Редактировать профиль', // Использование вашего меню для редактирования профиля
              icon: Icons.edit,
              onPress: () => Get.to(() => const UpdateProfileScreen()),
            ),
            ProfileMenuWidget(
              title: 'Другие опции', // Пример другого пункта меню
              icon: Icons.more_vert,
              onPress: () {
                // Добавьте обработчик события
              },
            ),
          ],
        ),
      ),
    );
  }
}
