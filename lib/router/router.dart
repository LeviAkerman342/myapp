import 'package:go_router/go_router.dart';
import 'package:myapp/feature/auntification/sign/sign.dart';
import 'package:myapp/feature/chat/chat.dart';
import 'package:myapp/feature/course/screens/dashboard_screen.dart';
import 'package:myapp/feature/favorite/favorite_screen.dart';
import 'package:myapp/feature/list_user/user_list.dart';
import 'package:myapp/feature/onbourding/onboarding_screen.dart';
import 'package:myapp/feature/profile/model/user_profile.dart';
import 'package:myapp/feature/profile/profile.dart';
import 'package:myapp/feature/profile/update_profile/update_profile.dart';
import 'package:myapp/feature/search/search_scree.dart';
import 'package:myapp/router/domain/model_router.dart';

import '../core/data/model/api/api_service.dart';

final authenticationRepository = AuthenticationRepository();

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
    GoRoute(
      path: SkillWaveRouter.chatUsers,
      builder: (context, state) => const UserSelectionScreen(),
    ),
    GoRoute(
      path: SkillWaveRouter.chat,
      builder: (context, state) {
        final user = state.extra as Map<String, dynamic>;
        return ChatScreen(user: user);
      },
    ),
    GoRoute(
      path: SkillWaveRouter.updateProfile,
      builder: (context, state) {
        final userProfile = state.extra as UserProfile;
        return UpdateProfileScreen(userProfile: userProfile);
      },
    ),
  ],
);
