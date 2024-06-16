import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/router/domain/model_router.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 47, 47, 47),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0, top: 6.0),
        child: SizedBox(
          height: 60.0,
          child: BottomAppBar(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(
                  context,
                  icon: Icons.home_outlined,
                  route: '/',
                ),
                _buildNavItem(
                  context,
                  icon: Icons.search_outlined,
                  route: SkillWaveRouter.search,
                ),
                _buildNavItem(
                  context,
                  icon: Icons.favorite_outline,
                  route: SkillWaveRouter.favorites,
                ),
                _buildNavItem(
                  context,
                  icon: Icons.chat_bubble_outline,
                  route: '/userSelection',
                ),
                _buildNavItem(
                  context,
                  icon: Icons.account_circle_outlined,
                  route: SkillWaveRouter.profile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, {required IconData icon, required String route}) {
    return IconButton(
      icon: Icon(icon),
      color: Colors.white,
      iconSize: 28.0,
      onPressed: () {
        GoRouter.of(context).go(route);
      },
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
      splashRadius: 24.0,
      splashColor: Colors.grey.shade800,
      hoverColor: Colors.grey.shade700,
    );
  }
}
