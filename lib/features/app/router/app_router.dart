import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kasi_chat/features/app/router/go_router_refresh_stream.dart';
import 'package:kasi_chat/features/app/router/router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class AppRouter {
  GoRouter get router => GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.chatList.route,
    refreshListenable: GoRouterAppBlocRefreshStream(),
    observers: [MyNavigatorObserver()],
    routes: [
      GoRoute(
        path: AppRoutes.splash.route,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Splash Page')),
        ),
      ),
      GoRoute(
        path: AppRoutes.authRoute.route,
        name: AppRoutes.authRoute.name,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Auth Page')),
        ),
      ),
      GoRoute(
        path: AppRoutes.login.route,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Login Page')),
        ),
      ),
       GoRoute(
        path: AppRoutes.register.route,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Register Page')),
        ),
      ),
      GoRoute(
        path: AppRoutes.profile.route,
        name: AppRoutes.profile.name,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Profile Page')),
        ),
      ),

      GoRoute(
        path: AppRoutes.chatList.route,
        name: AppRoutes.chatList.name,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Chat List Page')),
        ),
      ),
      GoRoute(
        path: AppRoutes.chat.path!,
        name: AppRoutes.chat.name,
        builder: (context, state) {
          final chatId = state.pathParameters['chat_id'];
          return Scaffold(
            body: Center(child: Text('Chat Page for chat ID: $chatId')),
          );
        },
      ),
       GoRoute(
        path: AppRoutes.fullscreen.route,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Fullscreen Page')),
        ),
      ),
    ],
    redirect: (context, state) {
      return null;
    },
  );
}
