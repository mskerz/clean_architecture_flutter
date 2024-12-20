import 'package:clean_architecture_flutter/core/errors/error_handler.dart';
import 'package:clean_architecture_flutter/features/authentication/presentation/screens/auth_login_screen.dart';
import 'package:clean_architecture_flutter/features/posts/presentation/screens/posts_screen.dart';
import 'package:clean_architecture_flutter/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Routes
enum AppRoute { onboarding, home, posts }

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: '/onboarding', // เริ่มต้นที่หน้า Onboarding
    routes: [
      // Onboarding Route
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (BuildContext context, GoRouterState state) {
          return OnboardingScreen(); // หน้าจอ Onboarding
        },
      ),
      // Login Route
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (BuildContext context, GoRouterState state) {
          return LoginScreen();
        },
      ),
      // Posts Route
      GoRoute(
        path: '/posts',
        name: 'posts',
        builder: (BuildContext context, GoRouterState state) {
          return PostsScreen();
        },
      ),
    ],
    errorBuilder: (context, state) => ErrorHandler.handleError(state.error),
  );

  static GoRouter get router => _router;
}
