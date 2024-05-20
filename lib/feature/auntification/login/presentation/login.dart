import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/core/data/model/api_service.dart';
import 'package:myapp/feature/auntification/login/viewmodel/login_view_model.dart';
import 'package:myapp/feature/profile/profile.dart';
import 'package:myapp/router/domain/model_router.dart';

class Login extends StatefulWidget {
  final LoginViewModel viewModel;
  final AuthenticationRepository authenticationRepository; // Добавьте поле для хранения экземпляра AuthenticationRepository

  const Login({
    Key? key,
    required this.viewModel,
    required this.authenticationRepository, // Инициализируйте поле в конструкторе
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  File? _image;

  Future<void> _getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
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
                'https://sun9-3.userapi.com/impg/zn38HQNq0QnVZlAxFyFfpq9U6dvQzm3WSelHLA/YE5kc5MPMGs.jpg?size=291x269&quality=96&sign=b4e9591ca8a1a99f897012b85c74bdaf&type=album',
                width: 291,
                height: 269,
              ),
              const SizedBox(height: 20),
              buildTextField(
                controller: nameController,
                hintText: 'Имя Фамилия',
              ),
              const SizedBox(height: 20),
              buildTextField(
                controller: emailController,
                hintText: 'Почта',
              ),
              const SizedBox(height: 20),
              buildTextField(
                controller: passwordController,
                hintText: 'Пароль',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _getImage,
                child: Container(
                  width: 282,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Stack(
                    children: [
                      Positioned(
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
                    final userProfile = UserProfile(
                      displayName: nameController.text.trim(),
                      email: emailController.text.trim(),
                      photoUrl: _image?.path ?? '',
                    );
                    context.go(
                      SkillWaveRouter.profile,
                      extra: userProfile,
                    );
                  } catch (e) {
                    print('Registration error: $e');
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
                      'Регистрация',
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
                onPressed: () async {
                  try {
                    // Вызов метода регистрации через AuthenticationRepository
                    await widget.authenticationRepository.registerUser(
                      userName: nameController.text.trim(),
                      email: emailController.text.trim(),
                      fullName:
                          '', // Здесь должно быть поле для полного имени пользователя
                      password: passwordController.text.trim(),
                      numberPhone:
                          '', // Здесь должно быть поле для номера телефона пользователя
                    );

                    // Переход на экран регистрации
                    context.go(SkillWaveRouter.signup);
                  } catch (e) {
                    print('Registration error: $e');
                  }
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

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return Container(
      width: 282,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        border: Border.all(color: Colors.black),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
