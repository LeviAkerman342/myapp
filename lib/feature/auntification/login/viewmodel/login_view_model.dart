import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/core/bloc/auntification/login_state_block.dart';
import 'package:myapp/feature/auntification/login/interface/registration_strategy.dart';

class LoginViewModel {
  final RegistrationStrategy registrationStrategy;
  final RegistrationStateManager registrationStateManager;

  LoginViewModel({
    required this.registrationStrategy,
    required this.registrationStateManager,
  });

  Future<void> registerPressed(BuildContext context, String name, String email,
      String password, File? image) async {
    // Обработка нажатия на кнопку регистрации
    registrationStateManager.startRegistration(
      context,
      name,
      email,
      password,
      image,
      registrationStrategy,
    );
  }
}
