import 'package:go_router/go_router.dart';
import 'package:minesweeper/pages/home/page.dart';
import 'package:minesweeper/pages/launch/splash/page.dart';

enum RouterPath {
  splash("/splash"),
  home("/home");

  const RouterPath(this.name);

  final String name;

  @override
  String toString() => name;

  static final routes = [
    GoRoute(
      path: RouterPath.splash.name,
      builder: (_, __) => const SplashPage(),
    ),
    GoRoute(
      path: RouterPath.home.name,
      builder: (_, __) => const HomePage(),
    ),
  ];
}
