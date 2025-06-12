import 'package:flutter/material.dart';
import 'package:minesweeper/l10n/localizations/app_localizations.dart';
import 'package:minesweeper/l10n/localizations/app_localizations_en.dart';

AppLocalizations appLocalizationsNoContext() {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  final locale = binding.platformDispatcher.locale;
  try {
    return lookupAppLocalizations(locale);
  } catch (_) {
    return AppLocalizationsEn();
  }
}
