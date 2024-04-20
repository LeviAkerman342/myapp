import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/feature/profile/update_profile/update_profile.dart';

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
    displayName: "John Doe",
    email: "john.doe@example.com",
    photoUrl: "https://example.com/profile.jpg",
  );

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Добавьте здесь код выхода из системы
              Get.offAllNamed('/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(userProfile.photoUrl),
            ),
            const SizedBox(height: 16),
            Text(userProfile.displayName,
                style: Theme.of(context).textTheme.titleLarge),
            Text(userProfile.email,
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Get.to(() => const UpdateProfileScreen()),
              child: const Text('Редактировать профиль'),
            ),
          ],
        ),
      ),
    );
  }
}
