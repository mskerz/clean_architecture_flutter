import 'package:clean_architecture_flutter/core/errors/error_handler.dart';
import 'package:clean_architecture_flutter/features/authentication/presentation/screens/auth_login_screen.dart';
import 'package:clean_architecture_flutter/features/posts/presentation/screens/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Routes
enum AppRoute { home, posts }

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      // Home Route
      GoRoute(
        path: '/',
        name: 'login',
        builder: (BuildContext context, GoRouterState state) {
          return LoginScreen();
        },
      ),
      // Detail Route
      GoRoute(
        path: '/posts',
        name: 'posts',
        builder: (BuildContext context, GoRouterState state) {
          return PostsScreen();
        },
      ),
      // Profile Route
      
    ],
    errorBuilder: (context, state) => ErrorHandler.handleError(state.error),);

  static GoRouter get router => _router;

  
}
