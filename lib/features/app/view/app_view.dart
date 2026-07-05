import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/core/di/di.dart';
import 'package:kasi_chat/features/app/app.dart';
import 'package:kasi_chat/features/app/bloc/app_bloc.dart';
import 'package:kasi_chat/l10n/gen/app_localizations.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final routerConfig = AppRouter();
    return BlocProvider<AppBloc>(
      create: (context) => sl<AppBloc>(),
      child: MaterialApp.router(
        routerConfig: routerConfig.router,
        title: 'Kasi Messenger'.hardcoded,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: const AppTheme().theme,
        darkTheme: const AppDarkTheme().theme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
