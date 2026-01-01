import 'package:flutter/widgets.dart';
import 'package:kasi_chat/l10n/gen/app_localizations.dart';

export 'package:kasi_chat/l10n/gen/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
