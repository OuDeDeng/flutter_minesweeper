// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homePageTitle => 'Minesweeper';

  @override
  String get gameRunning => 'Thinking...';

  @override
  String get gameWin => 'Congratulations! You Win!';

  @override
  String get gameLose => 'Game Over';
}
