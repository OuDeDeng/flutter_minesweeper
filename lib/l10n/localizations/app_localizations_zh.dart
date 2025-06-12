// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get homePageTitle => '扫雷';

  @override
  String get gameRunning => '思考中...';

  @override
  String get gameWin => '大吉大利，今晚吃鸡！';

  @override
  String get gameLose => '胜败乃兵家常事，大侠请从新来过';
}
