import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/feature/profile/model/user_profile.dart';
import 'package:myapp/feature/profile/profile_menu.dart';
import 'package:myapp/router/domain/model_router.dart';

class ProfileScreen extends StatelessWidget {
  final UserProfile userProfile;

  const ProfileScreen({
    super.key,
    required this.userProfile,
  });

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
                  : const AssetImage('assets/default_avatar.png')
                      as ImageProvider,
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
              onPress: () => context.push(SkillWaveRouter.updateProfile, extra: userProfile),
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
