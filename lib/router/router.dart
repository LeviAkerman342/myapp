import 'package:go_router/go_router.dart';
import 'package:myapp/core/data/model/api_service.dart';
import 'package:myapp/feature/auntification/sign/sign.dart';
import 'package:myapp/feature/course/screens/dashboard_screen.dart';
import 'package:myapp/feature/favorite/favorite_screen.dart';
import 'package:myapp/feature/onbourding/onboarding_screen.dart';
import 'package:myapp/feature/profile/profile.dart';
import 'package:myapp/feature/search/search_scree.dart';
import 'package:myapp/router/domain/model_router.dart';

// Assuming you have an instance of AuthenticationRepository
final authenticationRepository = AuthenticationRepository(); // Replace this with your actual instance

final router = GoRouter(
  initialLocation: SkillWaveRouter.onboarding,
  routes: [
    GoRoute(
      path: SkillWaveRouter.onboarding,
      builder: (context, state) => Onboarding(
        authenticationRepository: authenticationRepository,
      ),
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
      builder: (context, state) {
        final userProfile = state.extra as UserProfile;
        return ProfileScreen(userProfile: userProfile);
      },
    ),
    GoRoute(
      path: SkillWaveRouter.signup,
      builder: (context, state) => SignUp(),
    ),
  ],
);
