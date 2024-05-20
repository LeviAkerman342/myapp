import 'dart:io';

import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final IconData userIcon;
  final String userName;
  final IconData notificationIcon;
  final File? userImage;

  const NavBar({
    super.key,
    required this.userIcon,
    required this.userName,
    required this.notificationIcon,
    this.userImage, required Color backgroundColor, required Color textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (userImage != null)
                    CircleAvatar(
                      backgroundImage: FileImage(userImage!),
                      radius: 12,
                    ),
                  const SizedBox(width: 10),
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // Action when notification icon is tapped
                },
                child: Icon(
                  notificationIcon,
                  size: 24,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
