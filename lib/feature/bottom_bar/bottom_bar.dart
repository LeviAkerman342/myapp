import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/router/domain/model_router.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 47, 47, 47),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SizedBox(
          height: 60.0,
          width: 345.0,
          child: BottomAppBar(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.home),
                  color: Colors.white,
                  onPressed: () {
                    GoRouter.of(context).go(SkillWaveRouter.dashboard);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.white,
                  onPressed: () {
                    GoRouter.of(context).go(SkillWaveRouter.search);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.favorite),
                  color: Colors.white,
                  onPressed: () {
                    GoRouter.of(context).go(SkillWaveRouter.favorites);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.account_circle),
                  color: Colors.white,
                  onPressed: () {
                    GoRouter.of(context).go(SkillWaveRouter.profile);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

