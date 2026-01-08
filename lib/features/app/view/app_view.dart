import 'package:flutter/material.dart';
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
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
