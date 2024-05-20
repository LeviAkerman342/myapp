import 'package:go_router/go_router.dart';
import 'package:myapp/feature/course/screens/dashboard_screen.dart';
import 'package:myapp/feature/favorite/favorite_screen.dart';
import 'package:myapp/feature/onbourding/onboarding_screen.dart';
import 'package:myapp/feature/profile/profile.dart';
import 'package:myapp/feature/search/search_scree.dart';
import 'package:myapp/router/domain/model_router.dart';

final router = GoRouter(
  initialLocation:
      SkillWaveRouter.dashboard, 
  routes: [
    GoRoute(
      path: SkillWaveRouter.onboarding,
      builder: (context, state) => const Onboarding(),
    ),
    GoRoute(
      path: SkillWaveRouter.dashboard,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: SkillWaveRouter.favorites,
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: SkillWaveRouter.search,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: SkillWaveRouter.profile,
      builder: (context, state) => ProfileScreen(),
    ),
  ],
);
