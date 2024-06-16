import 'package:flutter/material.dart';
import 'package:myapp/feature/profile/model/user_profile.dart';

class UpdateProfileScreen extends StatefulWidget {
  final UserProfile userProfile;

  const UpdateProfileScreen({super.key, required this.userProfile});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.userProfile.displayName);
    _emailController = TextEditingController(text: widget.userProfile.email);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Профиль обновлен успешно')),
      );
      // Here you can add code to update the user's profile,
      // such as sending data to the server or saving it locally.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактировать профиль'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: widget.userProfile.photoUrl.isNotEmpty
                      ? NetworkImage(widget.userProfile.photoUrl)
                      : const AssetImage('assets/default_avatar.png') as ImageProvider,
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Полное имя',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Пожалуйста, введите ваше полное имя';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Электронная почта',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Пожалуйста, введите свой адрес электронной почты';
                  }
                  if (!value.contains('@')) {
                    return 'Пожалуйста, введите действительный адрес электронной почты';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Пароль',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: _togglePasswordVisibility,
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Пожалуйста, введите пароль';
                  }
                  if (value.length < 6) {
                    return 'Пароль должен состоять не менее чем из 6 символов';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: _updateProfile,
                  child: const Text('Сохранить изменения'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
