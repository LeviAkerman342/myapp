import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/feature/profile/profile_menu.dart';
import 'package:myapp/router/domain/model_router.dart';

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
  final UserProfile userProfile;

  ProfileScreen({
    Key? key,
    required this.userProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.go(SkillWaveRouter.dashboard);
          },
        ),
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
              context.go(SkillWaveRouter.onboarding);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: userProfile.photoUrl.isNotEmpty
                  ? FileImage(File(userProfile.photoUrl))
                  : const AssetImage('https://sun9-41.userapi.com/impg/w5a02deF_8VA1cYX9zUHEeQ-3rXkvHeqMY4vdQ/snNPB8fj0pg.jpg?size=736x736&quality=95&sign=4c9251caca6dccd708cb05c6e43d527c&type=album'),
              backgroundColor: Colors.grey[200],
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
              title: 'Редактировать профиль',
              icon: Icons.edit,
              onPress: () => context.push('/update-profile'), // Update this route if necessary
            ),
            ProfileMenuWidget(
              title: 'Другие опции',
              icon: Icons.more_vert,
              onPress: () {
                // Add event handler
              },
            ),
          ],
        ),
      ),
    );
  }
}
