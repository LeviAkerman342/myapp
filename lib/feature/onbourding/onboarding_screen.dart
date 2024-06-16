// File path: lib/feature/onboarding/onboarding.dart
import 'package:flutter/material.dart';
import 'package:myapp/core/data/model/login/login_with_image.dart';
import 'package:myapp/feature/auntification/login/presentation/login.dart';

import '../../core/bloc/auntification/login_state_block.dart';
import '../../core/data/model/api/api_service.dart';
import '../auntification/login/viewmodel/login_view_model.dart';

class Onboarding extends StatefulWidget {
  final AuthenticationRepository authenticationRepository;

  const Onboarding({super.key, required this.authenticationRepository});

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController controller = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!.round();
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: Alignment.center,
            children: [
              PageView(
                controller: controller,
                children: [
                  _buildPage(
                    imageUrl: 'https://i.postimg.cc/FsCcsdQG/First-Persons.png',
                    title: 'Добро пожаловать!',
                    subtitle:
                        'Приветствуем тебя на платформе, где ты сможешь раскрыть свой потенциал через обучение. Наши курсы созданы для того, чтобы помочь тебе освоить новые навыки, расширить горизонты и достичь новых вершин.',
                    constraints: constraints,
                  ),
                  _buildPage(
                    imageUrl: 'https://i.postimg.cc/FsH34bw7/Free-Persons.png',
                    title: 'Исследуй возможности',
                    subtitle:
                        'Наши курсы предоставляют уникальную возможность глубоко погрузиться в увлекательные области знаний. Давай вместе сделаем обучение интересным и продуктивным!',
                    constraints: constraints,
                  ),
                  _buildPage(
                    imageUrl: 'https://i.postimg.cc/FzDSS1kr/Two-Persons.png',
                    title: 'Погружение в обучение',
                    subtitle:
                        'Готов ли ты начать учиться? Вместе мы откроем новые горизонты и обретем новые навыки. Наши курсы разработаны для того, чтобы каждый шаг был увлекательным и образовательным.',
                    constraints: constraints,
                    isLastPage: true,
                  ),
                  Login(
                    viewModel: LoginViewModel(
                      registrationStrategy: RegistrationWithImage(),
                      registrationStateManager: RegistrationStateManager(),
                    ),
                    authenticationRepository: widget.authenticationRepository,
                  ),
                ],
              ),
              Positioned(
                bottom: 30,
                child: Visibility(
                  visible: currentPage != 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      Color color = index == currentPage ? Colors.black : Colors.grey;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              if (currentPage != 3)
                Positioned(
                  bottom: 80,
                  right: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      if (currentPage < 3) {
                        controller.animateToPage(
                          currentPage + 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPage({
    required String imageUrl,
    required String title,
    required String subtitle,
    required BoxConstraints constraints,
    bool isLastPage = false,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: constraints.maxWidth * 0.7,
              height: constraints.maxHeight * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: constraints.maxWidth * 0.06,
                fontFamily: 'Roboto Mono',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.03),
            SizedBox(
              width: constraints.maxWidth * 0.8,
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: constraints.maxWidth * 0.035,
                  fontFamily: 'Roboto Mono',
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ),
            if (isLastPage)
              Padding(
                padding: EdgeInsets.only(top: constraints.maxHeight * 0.1),
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (currentPage < 3) {
                      controller.animateToPage(
                        currentPage + 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
