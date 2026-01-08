import 'package:flutter/material.dart';
import 'package:kasi_chat/core/core.dart';
import 'package:kasi_chat/features/app/app.dart';
import 'package:kasi_chat/l10n/gen/app_localizations.dart';
import 'package:kasi_chat/l10n/string_hardcoded.dart';


class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final routerConfig = AppRouter();
    return MaterialApp.router(
      routerConfig: routerConfig.router,
      title: 'Kasi Chat'.hardcoded,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light, // TODO change to system when dark mode is ready
      theme: const AppTheme().theme,
      darkTheme: const AppDarkTheme().theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
