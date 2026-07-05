import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kasi_chat/core/di/di.dart';
import 'package:kasi_chat/features/app/bloc/app_bloc.dart';
import 'package:kasi_chat/features/app/router/go_router_refresh_stream.dart';
import 'package:kasi_chat/features/app/router/router.dart';
import 'package:kasi_chat/features/auth/view/auth_view.dart';
import 'package:kasi_chat/features/splash/splash.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

/// Router configuration for the app using GoRouter and BlocProvider
class AppRouter {
  GoRouter get router => GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash.route,
    refreshListenable: GoRouterAppBlocRefreshStream(sl<AppBloc>().stream),
    observers: [MyNavigatorObserver()],
    routes: [
      GoRoute(
        path: AppRoutes.splash.route,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRoutes.auth.route,
        name: AppRoutes.auth.name,
        builder: (context, state) => const AuthPage(),
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
        // name: AppRoutes.chatList.name,
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
      final authstate = sl<AppBloc>().state;

      final authenticated = authstate.status == AppStatus.authenticated;
      final authenticating = state.matchedLocation == AppRoutes.auth.route;
      final isInChatList = state.matchedLocation == AppRoutes.chatList.route;

      if (isInChatList && !authenticated) return AppRoutes.auth.route;
      if (!authenticated) return AppRoutes.auth.route;
      if (authenticating && authenticated) return AppRoutes.chatList.route;

      return null;
    },
  );
}
