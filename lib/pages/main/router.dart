import 'package:bot_toast/bot_toast.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minesweeper/l10n/localizations/app_localizations.dart';
import 'package:minesweeper/pages/color/manager.dart';
import 'package:minesweeper/pages/main/url.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class GoRouteApp extends StatelessWidget {
  GoRouteApp({super.key});

  final _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouterPath.splash.name,
    debugLogDiagnostics: true,
    observers: [BotToastNavigatorObserver()],
    routes: RouterPath.routes,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Minesweeper",
      theme: FlexThemeData.light(
        colors: FlexSchemeColor.from(primary: ColorManager.lightPrimary),
        useMaterial3: true,
        scaffoldBackground: ColorManager.lightScaffoldBackground,
      ),
      darkTheme: FlexThemeData.dark(
        colors: FlexSchemeColor.from(primary: ColorManager.darkPrimary),
        useMaterial3: true,
        scaffoldBackground: ColorManager.darkScaffoldBackground,
      ),
      routerConfig: _router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null) {
          for (final supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }
        return supportedLocales.first;
      },
      builder: BotToastInit(),
    );
  }
}
