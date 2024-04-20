import 'dart:io';

import 'package:flutter/material.dart';


class NavBar extends StatelessWidget {
  final IconData userIcon;
  final String userName;
  final IconData notificationIcon;
  final File? userImage; // Добавлено новое поле для изображения пользователя

  const NavBar({
    super.key, // Добавлено, чтобы не было ошибки супер-конструктора
    required this.userIcon,
    required this.userName,
    required this.notificationIcon,
    this.userImage, // Инициализируем поле изображения пользователя
  }); // Вызываем супер-конструктор

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Если есть изображение пользователя, отобразим его
                  if (userImage != null)
                    CircleAvatar(
                      backgroundImage: FileImage(userImage!),
                      radius: 12,
                    ),
                  const SizedBox(width: 10),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xffab93e0),
                      fontFamily: 'Oddval-SemiBold',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // Действие при нажатии на иконку уведомлений
                },
                child: Icon(
                  notificationIcon,
                  size: 24,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}