import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/core/data/model/api_service.dart';
import 'package:myapp/feature/auntification/login/viewmodel/login_view_model.dart';
import 'package:myapp/router/domain/model_router.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  File? _image;
  late final AuthenticationRepository
      authenticationRepository; // Добавьте поле для хранения экземпляра AuthenticationRepository

  late final LoginViewModel viewModel;

  SignUp({super.key});



  Future<void> _getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _image = File(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'SkillWeave',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                '../assets/image/logo_login.png',
                width: 291,
                height: 269,
              ),
              const SizedBox(height: 20),
              Container(
                width: 282,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                ),
                child: TextField(
                  controller: emailController,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Почта',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 282,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Пароль',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  await _getImage();
                  if (_image != null) {
                    print('Фото выбрано: ${_image!.path}');
                  }
                },
                child: Container(
                  width: 282,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: 67,
                        height: 26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.white,
                        ),
                      ),
                      const Stack(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 18.000001907348633,
                          ),
                          SizedBox(
                            width: 8,
                            height: 8.000000953674316,
                          ),
                        ],
                      ),
                      const Positioned(
                        left: 8,
                        top: 6,
                        child: Icon(
                          Icons.camera_alt,
                          color: Color.fromARGB(255, 203, 203, 203),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Здесь выполняем логику регистрации
                    // await viewModel.register(
                    //   name: nameController.text.trim(),
                    //   email: emailController.text.trim(),
                    //   password: passwordController.text.trim(),
                    //   image: _image,
                    // );

                    // Если регистрация прошла успешно, переходим на следующий экран
                    context.go(SkillWaveRouter.dashboard);
                  } catch (e) {
                    // Обработка ошибок регистрации
                    print('Ошибка регистрации: $e');
                    // В случае ошибки регистрации также переходим на следующий экран
                    context.go(SkillWaveRouter.dashboard);
                    // Дополнительно можно показать сообщение пользователю
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E1E1E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Войти',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  authenticationRepository.authenticateUser(
                      emailController.text.trim(),
                      passwordController.text.trim());

                  context.go(SkillWaveRouter.signup);
                },
                child: const Text(
                  'Уже есть аккаунт? Войти',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
